//
//  SettingsViewController.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 01/02/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *swRememberMe;
@property (weak, nonatomic) IBOutlet UISwitch *swAutoLogin;
@property (weak, nonatomic) IBOutlet UISwitch *swRefreshAlerts;
@property (weak, nonatomic) IBOutlet UILabel *labRefreshAlerts;
@property (weak, nonatomic) IBOutlet UISlider *slRefreshAlerts;
@property (weak, nonatomic) IBOutlet UISwitch *swRefreshCharts;
@property (weak, nonatomic) IBOutlet UILabel *labRefreshCharts;
@property (weak, nonatomic) IBOutlet UISlider *slRefreshCharts;
@property (weak, nonatomic) IBOutlet UITextField *tfApiUrl;


@end
