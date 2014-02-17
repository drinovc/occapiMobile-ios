//
//  SettingsViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 01/02/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsKeys.h"
#import "ECSlidingViewController.h"
#import "DataClass.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize swRememberMe, swAutoLogin, swRefreshAlerts, labRefreshAlerts, slRefreshAlerts, swRefreshCharts, labRefreshCharts, slRefreshCharts, tfApiUrl;

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
    //ECSlidingViewController *slidingViewController = (ECSlidingViewController*)self.navigationController.parentViewController;
    //[self.view addGestureRecognizer:slidingViewController.panGesture];

    // loading settings values
    swRememberMe.on = [[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME];
    swAutoLogin.on = [[NSUserDefaults standardUserDefaults] boolForKey:AUTO_LOGIN];
    swAutoLogin.enabled = [[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME];
    
    swRefreshAlerts.on = [[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_ALERTS];
    labRefreshAlerts.text = [NSString stringWithFormat:@"%.fs", [[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_ALERTS_TIMEOUT]];
    slRefreshAlerts.value = [[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_ALERTS_TIMEOUT];
    slRefreshAlerts.enabled = [[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_ALERTS];
    
    swRefreshCharts.on = [[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_CHARTS];
    labRefreshCharts.text = [NSString stringWithFormat:@"%.fs", [[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_CHARTS_TIMEOUT]];
    slRefreshCharts.value = [[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_CHARTS_TIMEOUT];
    slRefreshCharts.enabled = [[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_CHARTS];
    
    tfApiUrl.text = [[NSUserDefaults standardUserDefaults] objectForKey:API_URL];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(self.isMovingFromParentViewController) {
        
    }
}
*/

#pragma saving settings values
- (IBAction)swRemeberMeValueChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:REMEMBER_ME];
    swAutoLogin.enabled = sender.on;
    if(sender.on) {
        DataClass *d = [DataClass instance];
        [[NSUserDefaults standardUserDefaults] setObject:d.email forKey:EMAIL];
    }
}

- (IBAction)swAutoLoginValueChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:AUTO_LOGIN];
    if(sender.on) {
        DataClass *d = [DataClass instance];
        [[NSUserDefaults standardUserDefaults] setObject:d.password forKey:PASSWORD];
    }
}

- (IBAction)swRefreshAlertsValueChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:REFRESH_ALERTS];
    slRefreshAlerts.enabled = sender.on;
}

- (IBAction)slRefreshAlertsValueChanged:(UISlider *)sender
{
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:REFRESH_ALERTS_TIMEOUT];
    labRefreshAlerts.text = [NSString stringWithFormat:@"%.fs", sender.value];
}

- (IBAction)swRefreshChartsValueChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:REFRESH_CHARTS];
    slRefreshCharts.enabled = sender.on;
}

- (IBAction)slRefreshChartsValueChanged:(UISlider *)sender
{
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:REFRESH_CHARTS_TIMEOUT];
    labRefreshCharts.text = [NSString stringWithFormat:@"%.fs", sender.value];
}

- (IBAction)tfApiUrlValueChanged:(UITextField *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:sender.text forKey:API_URL];
}


@end
