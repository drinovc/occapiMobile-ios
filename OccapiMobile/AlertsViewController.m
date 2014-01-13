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

@interface AlertsViewController ()

@end

@implementation AlertsViewController
@synthesize alertsList, kpiNo, kpiCaption, kpiName, _loadingIndicator;

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
    NSString *kpiGroupCaption = [_d.kpiGroup objectForKey:@"kpiCaption"];
    self.title = kpiGroupCaption;
    
    // don't show empty table cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // init loading indicator
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingIndicator.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height) / 3);
    _loadingIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_loadingIndicator];
    [_loadingIndicator startAnimating];
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api loadAlerts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *reason = [alert objectForKey:@"reason"];
    NSNumber *timestamp = [alert objectForKey:@"timestamp"];
    
    NSString *timeStampString = [NSString stringWithFormat:@"%f", [timestamp doubleValue] / 1000.0];
    NSTimeInterval _interval = [timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter = [[NSDateFormatter alloc]init];
    
    DataClass *_d = [DataClass instance];
    [_formatter setDateFormat:_d.dateTimeFormat];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_formatter stringFromDate:date]];
    cell.detailTextLabel.text = reason;
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void) loadAlertsCompleted:(BOOL)success :(NSString*)message :(NSDictionary*)json
{
    [_loadingIndicator stopAnimating];
    
    if(!self.view.hidden) {
        if(success) {
            NSArray *jsonArray = [json objectForKey:@"alerts"];
            alertsList = [jsonArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                NSString *alertKpiName = [evaluatedObject objectForKey:@"kpiName"];
                return [alertKpiName isEqualToString:kpiName];
            }]];
            if([alertsList count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerts" message:@"No alerts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                [self.tableView  reloadData];
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
