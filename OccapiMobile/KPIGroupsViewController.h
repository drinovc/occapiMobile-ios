//
//  KPIGroupsViewController.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPIGroupsViewController : UITableViewController
@property(nonatomic, strong) NSArray *kpiGroupsList;

@property(nonatomic, strong) UIActivityIndicatorView *_loadingIndicator;

@end
