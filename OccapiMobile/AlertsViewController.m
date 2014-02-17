//
//  AlertsViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "AlertsViewController.h"
#import "DataClass.h"
#import "API.h"
#import "SettingsKeys.h"

@interface AlertsViewController ()

@end

@implementation AlertsViewController
@synthesize alertsList, kpiNo, kpiName, _loadingIndicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    DataClass *_d = [DataClass instance];
    kpiName = [_d.kpi objectForKey:@"kpiName"];
    NSString *kpiCaption = [_d.kpi objectForKey:@"kpiCaption"];
    self.title = kpiCaption;
    
    // don't show empty table cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // init loading indicator
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingIndicator.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height) / 3);
    _loadingIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_loadingIndicator];
    [_loadingIndicator startAnimating];
    
    [self loadAlerts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)didMoveToParentViewController:(UIViewController *)parent
{

}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(self.isMovingFromParentViewController) {
        // stop refreshing alerts on view exit
        DataClass *d = [DataClass instance];
        d.kpi = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return alertsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *alert = [alertsList objectAtIndex:indexPath.row];
    NSString *level = [alert objectForKey:@"level"];
    NSString *reason = [alert objectForKey:@"reason"];
    NSNumber *timestamp = [alert objectForKey:@"timestamp"];
    
    NSString *timeStampString = [NSString stringWithFormat:@"%f", [timestamp doubleValue] / 1000.0];
    NSTimeInterval _interval = [timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter = [[NSDateFormatter alloc]init];
    
    DataClass *_d = [DataClass instance];
    [_formatter setDateFormat:_d.dateTimeFormat];
    
    if([level isEqualToString:@"LEVEL0"]) {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    else if([level isEqualToString:@"LEVEL1"]) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = reason;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [_formatter stringFromDate:date]];;
    
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void) loadAlerts
{
    NSLog(@"Load alerts");
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api loadAlerts];
}

// called from API
- (void) loadAlertsCompleted:(BOOL)success :(NSString*)message :(NSDictionary*)json
{
    [_loadingIndicator stopAnimating];
    
    DataClass *d = [DataClass instance];
    NSString *dKpiName = d.kpi ? [d.kpi objectForKey:@"kpiName"] : nil;
    
    if(dKpiName && [dKpiName isEqualToString:kpiName]) {
        if(success) {
            NSArray *jsonArray = [json objectForKey:@"alerts"];
            alertsList = [jsonArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                NSString *alertKpiName = [evaluatedObject objectForKey:@"kpiName"];
                return [alertKpiName isEqualToString:kpiName];
            }]];
            alertsList = [alertsList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                NSNumber *t1 = [a objectForKey:@"timestamp"];
                NSNumber *t2 = [b objectForKey:@"timestamp"];
                return [t2 compare:t1];
            }];
            
            if([alertsList count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerts" message:@"No alerts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                [self.tableView  reloadData];
                
                // loop loading alerts
                if([[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_ALERTS]) {
                    float delay = lroundf([[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_ALERTS_TIMEOUT]);
                    [self performSelector:@selector(loadAlerts) withObject:nil afterDelay:delay];
                }
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load alerts error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
