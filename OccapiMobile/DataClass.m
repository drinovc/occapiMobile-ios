//
//  DataClass.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 11/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass
@synthesize dateTimeFormat, timeFormat, token, email, password, kpiGroup, kpi;

static DataClass *instance = nil;
+(DataClass*) instance {
    @synchronized(self) {
        if(instance == nil) {
            instance = [DataClass new];
            instance.dateTimeFormat = @"yyyy-MM-dd 'at' HH:mm:ss";
            instance.timeFormat = @"HH:mm:ss";
         }
        return instance;
    }
}
@end
