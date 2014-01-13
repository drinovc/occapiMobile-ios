//
//  KPIsViewController.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"
#import "API.h"

@interface KPIsViewController : UITableViewController
@property(nonatomic, strong) NSArray *kpisList;

@property(nonatomic, strong) UIActivityIndicatorView *_loadingIndicator;

@end
