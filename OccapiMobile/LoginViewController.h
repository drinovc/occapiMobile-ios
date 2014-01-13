//
//  LoginViewController.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIView *loginContainer;
@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UIButton *btnSignIn;

@property(nonatomic, strong) NSArray *kpiGroups;
@property(nonatomic, strong) UIActivityIndicatorView *_loadingIndicator;

@end
