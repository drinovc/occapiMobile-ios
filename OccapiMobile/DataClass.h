//
//  DataClass.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 11/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//
//  This class holds global variables for usage in any view
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject {
    NSString *dateTimeFormat;
    NSString *token;
    NSString *email;
    NSString *password;
    NSDictionary *kpiGroup;
    NSDictionary *kpi;
    
}
@property(nonatomic, retain) NSString *dateTimeFormat;
@property(nonatomic, retain) NSString *timeFormat;
@property(nonatomic, retain) NSString *token;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSDictionary *kpiGroup;
@property(nonatomic, retain) NSDictionary *kpi;
+(DataClass*) instance;
@end
