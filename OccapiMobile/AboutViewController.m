//
//  AboutViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 01/02/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "AboutViewController.h"
#import "ECSlidingViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
	// Do any additional setup after loading the view.
    
    // adding gesture recognizer
    ECSlidingViewController *slidingViewController = (ECSlidingViewController*)self.navigationController.parentViewController;
    [self.view addGestureRecognizer:slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
