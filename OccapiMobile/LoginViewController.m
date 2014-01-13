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

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginContainer, tfEmail, tfPassword, btnSignIn, kpiGroups, _loadingIndicator;

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
    
    // init loading indicator
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingIndicator.center = self.view.center;
    _loadingIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_loadingIndicator];
    
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
    loginContainer.hidden = YES;
    [_loadingIndicator startAnimating];
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api login:tfEmail.text :tfPassword.text];
}

- (void) loginCompleted:(BOOL)success :(NSString*)message
{
    NSLog(@"Login completed");
    
    if(success) {
        API *_api = [[API alloc] init];
        _api.delegate = self;
        [_api loadKPIGroups];
    }
    else {
        // show alert about incorrect credentials
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) loadKPIGroupsCompleted:(BOOL)success :(NSString*)message :(NSArray*)jsonArray;
{
    NSLog(@"Load KPI Groups completed");
    
    if(success) {
        kpiGroups = jsonArray;
        
        // load view - set segue id on view -> next view !!!
        [self performSegueWithIdentifier:@"showKPIGroups" sender:self];
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
    KPIGroupsViewController * KPIGVC = [[KPIGroupsViewController alloc]init];
    KPIGVC = [segue destinationViewController];
    KPIGVC.kpiGroupsList = kpiGroups;
}

@end
