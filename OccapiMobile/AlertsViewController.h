//
//  AlertsViewController.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertsViewController : UITableViewController
@property(nonatomic, strong) NSArray *alertsList;
@property int kpiNo;
@property (nonatomic, strong) NSString *kpiCaption;
@property (nonatomic, strong) NSString *kpiName;

@property(nonatomic, strong) UIActivityIndicatorView *_loadingIndicator;

@end
