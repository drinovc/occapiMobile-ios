//
//  API.h
//  OccapiMobile
//
//  Created by Rok Drinovec on 12/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIDelegate <NSObject>
@required
- (void) loginCompleted:(BOOL)success :(NSString*)message;
- (void) loadKPIGroupsCompleted:(BOOL)success :(NSString*)message :(NSArray*)jsonArray;
- (void) loadKPIsCompleted:(BOOL)success :(NSString*)message :(NSArray*)jsonArray;
- (void) loadAlertsCompleted:(BOOL)success :(NSString*)message :(NSDictionary*)json;
- (void) loadChartCompleted:(BOOL)success :(NSString*)message :(NSDictionary*)json;
@end

@interface API : NSObject
{
    // delegate to respond back
    id <APIDelegate> _delegate;
}
@property (nonatomic, strong) id delegate;

- (void) login:(NSString*)email :(NSString*)password;
- (void) loadKPIGroups;
- (void) loadKPIs;
- (void) loadAlerts;
- (void) loadChart;

@end
