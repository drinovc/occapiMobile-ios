//
//  DataClass.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 11/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass
@synthesize apiUrl, dateTimeFormat, token, kpiGroup, kpi;

static DataClass *instance = nil;
+(DataClass*) instance {
    @synchronized(self) {
        if(instance == nil) {
            instance = [DataClass new];
            instance.apiUrl = @"http://212.235.191.163:8080/inteliui/resources/";
            instance.dateTimeFormat = @"yyyy-MM-dd 'at' HH:mm:ss";
         }
        return instance;
    }
}
@end
