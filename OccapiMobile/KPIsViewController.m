//
//  KPIsViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "KPIsViewController.h"
#import "AlertsViewController.h"
#import "DataClass.h"
#import "API.h"

@interface KPIsViewController ()

@end

@implementation KPIsViewController
@synthesize kpisList, _loadingIndicator;

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
    self.clearsSelectionOnViewWillAppear = NO;
    
    DataClass *_d = [DataClass instance];
    NSString *kpiGroupCaption = [_d.kpiGroup objectForKey:@"kpiGroupCaption"];
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
    [_api loadKPIs];
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
    return kpisList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *kpi = [kpisList objectAtIndex:indexPath.row];
    NSString *caption = [kpi objectForKey:@"kpiCaption"];
    NSString *monitor = [kpi objectForKey:@"monitorName"];
    NSString *imgName = [NSString stringWithFormat:@"%@.png", monitor];
    
    cell.textLabel.text = caption;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:imgName];
    
    return cell;
}

// called from API
- (void) loadKPIsCompleted:(BOOL)success :(NSString*)message :(NSArray*)jsonArray
{
    [_loadingIndicator stopAnimating];

    if(!self.view.hidden) {
        if(success) {
            kpisList = jsonArray;
            if([kpisList count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KPIs" message:@"No KPIs" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:  nil, nil];
                [alert show];
            }
            else {
                [self.tableView  reloadData];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load KPIs error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    DataClass *_d = [DataClass instance];
    _d.kpi = [kpisList objectAtIndex:path.row];
    
    NSString *monitorName = [_d.kpi objectForKey:@"monitorName"];
    
    // load view - set segue id on view -> next view !!!
    if([monitorName isEqualToString:@"line_chart"]) {
        [self performSegueWithIdentifier:@"showLineChart" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"showAlerts" sender:self];
    }
    
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
