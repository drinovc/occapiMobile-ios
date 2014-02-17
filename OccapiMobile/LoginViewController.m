//
//  LoginViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 06/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "LoginViewController.h"
#import "KPIGroupsViewController.h"
#import "DataClass.h"
#import "API.h"
#import "DataClass.h"
#import "ECSlidingViewController.h"
#import "SettingsKeys.h"
#import "MEMenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginContainer, tfEmail, tfPassword, btnSignIn, dismissAutoLogin, kpiGroups, _loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // adding gesture recognizer
    // ECSlidingViewController *slidingViewController = (ECSlidingViewController*)self.navigationController.parentViewController;
    // [self.view addGestureRecognizer:slidingViewController.panGesture];
    
    // init loading indicator
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingIndicator.center = self.view.center;
    _loadingIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_loadingIndicator];
    
    // style sign in button
    
    // set login data
    if([[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME]) {
        tfEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL];
        if([[NSUserDefaults standardUserDefaults] boolForKey:AUTO_LOGIN]) {
            tfPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD];
            if(!self.dismissAutoLogin) {
                [self signIn];
            }
        }
    }
    
    loginContainer.center = self.view.center; // not working
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide navigation bar on view show
- (void)viewWillAppear:(BOOL)animated
{
    [_loadingIndicator stopAnimating];
    loginContainer.hidden = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

// show navigation bar on view hide
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)btnSignInPressed:(id)sender
{
    [self signIn];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self signIn];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)signIn
{
    if(tfEmail.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in error" message:@"You must enter valid email " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if(tfPassword.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in error" message:@"Yout must enter password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    loginContainer.hidden = YES;
    [_loadingIndicator startAnimating];
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api login:tfEmail.text :tfPassword.text];
}

// called from API
- (void) loginCompleted:(BOOL)success :(NSString*)message
{
    NSLog(@"Login completed");
    
    if(success) {
        ECSlidingViewController *slidingViewController = (ECSlidingViewController *)self.navigationController.parentViewController;
        [slidingViewController setTopViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"KPIGroupsNavigationController"]];
        slidingViewController.anchorLeftPeekAmount = 50.0;
        slidingViewController.anchorLeftRevealAmount = 200.0;
        slidingViewController.anchorRightPeekAmount = 50.0;
        slidingViewController.anchorRightRevealAmount = 200.0;
        [slidingViewController resetTopViewAnimated:NO];
        
        // selecting first row in menu
        MEMenuViewController *menu = (MEMenuViewController *)slidingViewController.underLeftViewController;
        [menu.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection: 0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        DataClass *d = [DataClass instance];
        d.email = tfEmail.text;
        d.password = tfPassword.text;
        
        // store login data
        if([[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME]) {
            [[NSUserDefaults standardUserDefaults] setObject:tfEmail.text forKey:EMAIL];
            if([[NSUserDefaults standardUserDefaults] boolForKey:AUTO_LOGIN]) {
                [[NSUserDefaults standardUserDefaults] setObject:tfPassword.text forKey:PASSWORD];
            }
        }
    }
    else {
        // show alert about incorrect credentials
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        loginContainer.hidden = NO;
        [_loadingIndicator stopAnimating];
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
