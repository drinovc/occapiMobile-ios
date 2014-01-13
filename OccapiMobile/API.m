//
//  API.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 12/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "API.h"
#import "DataClass.h"

@implementation API

- (void) login:(NSString*)email :(NSString*)password;
{
    DataClass *d = [DataClass instance];
    NSString *urlAsString = [NSString stringWithFormat:@"%@login/%@/%@", d.apiUrl, email, password];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError) {
            [self.delegate loginCompleted:NO : @"Connection error"];
        }
        else {
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *token = [json objectForKey:@"token"];
            NSString *message = [json objectForKey:@"message"];
            
            if((NSNull*)token == [NSNull null]) {
                [self.delegate loginCompleted:NO : message];
            }
            else {
                NSLog(@"token: %@", token);
                d.token = token;
                [self.delegate loginCompleted:YES : message];
            }
        }
    }];
}

- (void) loadKPIGroups
{
    DataClass *d = [DataClass instance];
    
    NSString *urlAsString = [NSString stringWithFormat:@"%@kpigroup/user/%@", d.apiUrl, d.token];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError) {
            [self.delegate loadKPIGroupsCompleted:NO : @"Connection error" : nil];
        }
        else {
            NSError *error;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if([jsonArray count] == 0) {
                [self.delegate loadKPIGroupsCompleted:NO : @"Result is empty" : nil];
            }
            else {
                [self.delegate loadKPIGroupsCompleted:YES : @"KPI Groups loaded" : jsonArray];
            }
        }
    }];
}

- (void) loadKPIs
{
    DataClass *d = [DataClass instance];
    NSString *kpiGroupName = [d.kpiGroup objectForKey:@"kpiGroupName"];
    
    NSString *urlAsString = [NSString stringWithFormat:@"%@kpi/group/%@/user/%@", d.apiUrl, kpiGroupName, d.token];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError) {
            [self.delegate loadKPIsCompleted:NO : @"Connection error" : nil];
        }
        else {
            NSError *error;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if([jsonArray count] == 0) {
                [self.delegate loadKPIsCompleted:NO : @"Result is empty" : nil];
            }
            else {
                [self.delegate loadKPIsCompleted:YES : @"KPIs loaded" : jsonArray];
            }
        }
    }];
}

- (void) loadAlerts
{
    DataClass *d = [DataClass instance];
    NSString *urlAsString = [NSString stringWithFormat:@"%@alerts/all_alerts/token/%@", d.apiUrl, d.token];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError) {
            [self.delegate loadAlertsCompleted:NO : @"Connection error" : nil];
        }
        else {
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if([json count] == 0) {
                [self.delegate loadAlertsCompleted:NO : @"Result is empty" : nil];
            }
            else {
                [self.delegate loadAlertsCompleted:YES : @"KPIs loaded" : json];
            }
        }
    }];
}


@end
