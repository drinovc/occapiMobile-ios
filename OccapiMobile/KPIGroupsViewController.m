//
//  KPIGroupsViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "KPIGroupsViewController.h"
#import "KPIsViewController.h"
#import "DataClass.h"
#import "API.h"
#import "ECSlidingViewController.h"

@interface KPIGroupsViewController ()

@end

@implementation KPIGroupsViewController
@synthesize kpiGroupsList, _loadingIndicator;

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"WORKING!");
}

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

    // adding gesture recognizer
    ECSlidingViewController *slidingViewController = (ECSlidingViewController *)self.navigationController.parentViewController;
    [self.view addGestureRecognizer:slidingViewController.panGesture];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // don't show empty table cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = @"KPI Groups";
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api loadKPIGroups];
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
    return kpiGroupsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *group = [kpiGroupsList objectAtIndex:indexPath.row];
    NSString *caption = [group objectForKey:@"kpiGroupCaption"];
    
    cell.textLabel.text = caption;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// called from API
- (void) loadKPIGroupsCompleted:(BOOL)success :(NSString*)message :(NSArray*)jsonArray;
{
    NSLog(@"Load KPI Groups completed");
    
    if(success) {
        kpiGroupsList = jsonArray;
        
        if([kpiGroupsList count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KPI Groups" message:@"No KPI Groups" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:  nil, nil];
            [alert show];
        }
        else {
            [self.tableView  reloadData];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load KPI Groups error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    DataClass *_d = [DataClass instance];
    _d.kpiGroup = [kpiGroupsList objectAtIndex:path.row];
}

@end
