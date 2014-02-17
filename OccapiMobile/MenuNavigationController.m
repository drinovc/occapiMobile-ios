//
//  MenuNavigationController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 28/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "MenuNavigationController.h"
//#import "ECSlidingViewController.h"

@interface MenuNavigationController ()

@end

@implementation MenuNavigationController

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

    // adding shadows for navigation view
    [self.view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.view.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.view.layer setShadowRadius:15.0];
    [self.view.layer setShadowOpacity:1];
    [self.view.layer setMasksToBounds:NO];
    [self.view setClipsToBounds:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
