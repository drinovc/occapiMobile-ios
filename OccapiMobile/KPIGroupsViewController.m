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

@interface KPIGroupsViewController ()

@end

@implementation KPIGroupsViewController
@synthesize kpiGroupsList, _loadingIndicator;

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
    
    // don't show empty table cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = @"KPI Groups";
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
