//
//  LineChartViewController.m
//  OccapiMobile
//
//  Created by Rok Drinovec on 12/01/14.
//  Copyright (c) 2014 Rok Drinovec. All rights reserved.
//

#import "LineChartViewController.h"
#import "DataClass.h"
#import "API.h"
#import "LCLineChartView.h"
#import "SettingsKeys.h"

@interface LineChartViewController ()

@property (strong) NSDateFormatter *formatter;

@end

@implementation LineChartViewController
@synthesize kpiName;

#define SECS_PER_DAY (86400)

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
    
    DataClass *_d = [DataClass instance];
    kpiName = [_d.kpi objectForKey:@"kpiName"];
    NSString *kpiCaption = [_d.kpi objectForKey:@"kpiCaption"];
    self.title = kpiCaption;
    
    [self loadChart];
   
    
    /*
    {
        self.formatter = [[NSDateFormatter alloc] init];
        [self.formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyMMMd" options:0 locale:[NSLocale currentLocale]]];
    }
    
    LCLineChartData *d1x = [LCLineChartData new];
    {
        LCLineChartData *d1 = d1x;
        // el-cheapo next/prev day. Don't use this in your Real Code (use NSDateComponents or objc-utils instead)
        NSDate *date1 = [[NSDate date] dateByAddingTimeInterval:((-3) * SECS_PER_DAY)];
        NSDate *date2 = [[NSDate date] dateByAddingTimeInterval:((2) * SECS_PER_DAY)];
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = @"Foobarbang";
        d1.color = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
        d1.itemCount = 6;
        NSMutableArray *arr = [NSMutableArray array];
        for(NSUInteger i = 0; i < 4; ++i) {
            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        [arr addObject:@(d1.xMin)];
        [arr addObject:@(d1.xMax)];
        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < 6; ++i) {
            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            NSString *label1 = [self.formatter stringFromDate:[date1 dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LCLineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
    }
    
    LCLineChartData *d2x = [LCLineChartData new];
    {
        LCLineChartData *d1 = d2x;
        NSDate *date1 = [[NSDate date] dateByAddingTimeInterval:((-3) * SECS_PER_DAY)];
        NSDate *date2 = [[NSDate date] dateByAddingTimeInterval:((2) * SECS_PER_DAY)];
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = @"Bar";
        d1.color = [UIColor colorWithRed:248.0/255.0 green:153.0/255.0 blue:29.0/255.0 alpha:1.0];
        d1.itemCount = 8;
        NSMutableArray *arr = [NSMutableArray array];
        for(NSUInteger i = 0; i < d1.itemCount - 2; ++i) {
            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        [arr addObject:@(d1.xMin)];
        [arr addObject:@(d1.xMax)];
        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            NSString *label1 = [self.formatter stringFromDate:[date1 dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LCLineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
    }
    
    // get view size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    LCLineChartView *chartView = [[LCLineChartView alloc] initWithFrame:CGRectMake(0, (navHeight + 20), screenWidth, screenHeight - (navHeight + 20))];
    chartView.yMin = 0;
    chartView.yMax = 6;
    chartView.ySteps = @[@"1.0",@"2.0",@"3.0",@"4.0",@"5.0",@"6.0"];
    chartView.data = @[d1x,d2x];
    
    [self.view addSubview:chartView];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)didMoveToParentViewController:(UIViewController *)parent
{
    
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(self.isMovingFromParentViewController) {
        // stop refreshing alerts on view exit
        DataClass *d = [DataClass instance];
        d.kpi = nil;
    }
}

- (void) loadChart
{
    NSLog(@"Load chart");
    
    API *_api = [[API alloc] init];
    _api.delegate = self;
    [_api loadChart];
}

// called from API
- (void) loadChartCompleted:(BOOL)success :(NSString*)message :(NSDictionary*)json
{
    DataClass *d = [DataClass instance];
    NSString *dKpiName = d.kpi ? [d.kpi objectForKey:@"kpiName"] : nil;
    
    if(dKpiName && [dKpiName isEqualToString:kpiName]) {
        if(success) {
            NSDictionary *flotDTO = [json objectForKey:@"flotDTO"];
            NSArray *seriesSet = [flotDTO objectForKey:@"seriesSet"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            
            DataClass *_d = [DataClass instance];
            [formatter setDateFormat:_d.timeFormat];
            
            if(seriesSet.count > 0) {
                NSMutableArray *chartSeries = [[NSMutableArray alloc]init];
                double yMin = FLT_MAX;
                double yMax = FLT_MIN;
                
                for (NSUInteger s = 0; s < seriesSet.count; s++) {
                    NSDictionary *series = seriesSet[s];
                    NSString *seriesLabel = [series objectForKey:@"label"];
                    NSArray *data = [series objectForKey: @"data"];
                    
                    long xMin = FLT_MAX;
                    long xMax = FLT_MIN;
                    
                    LCLineChartData *dx = [LCLineChartData new];
                    {
                        LCLineChartData *d1 = dx;
                        
                        switch(s) {
                            case 0: d1.color = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0]; break;
                            case 1: d1.color = [UIColor colorWithRed:248.0/255.0 green:153.0/255.0 blue:29.0/255.0 alpha:1.0]; break;
                            case 2: d1.color = [UIColor colorWithRed:52.0/255.0 green:147.0/255.0 blue:244.0/255.0 alpha:1.0]; break;
                        }
                        
                        for (int p = 0; p < data.count; p++) {
                            NSArray *point = data[p];
                            long pX = [point[0] longValue] / 1000;
                            double pY = [point[1] doubleValue];
                            
                            // store min/max values for x an y
                            xMin = pX < xMin ? pX : xMin;
                            xMax = pX > xMax ? pX : xMax;
                            yMin = pY < yMin ? pY : yMin;
                            yMax = pY > yMax ? pY : yMax;
                        }
                        
                        d1.xMin = 0;
                        d1.xMax = xMax - xMin;
                        
                        d1.title = seriesLabel;
                        d1.itemCount = data.count;
                        
                        d1.getData = ^(NSUInteger item) {
                            NSArray *point = [data objectAtIndex:item];
                            long t = ([point[0] doubleValue] / 1000);
                            float x = (float)(t - xMin);
                            float y = [point[1] floatValue];
                            
                            NSString *timeStampString = [NSString stringWithFormat:@"%ld", t];
                            NSTimeInterval _interval = [timeStampString doubleValue];
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                            
                            NSString *labelX = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
                            //NSString *labelX = [NSString stringWithFormat:@"%ld", x];
                            NSString *labelY = [NSString stringWithFormat:@"%.f", y];
                            return [LCLineChartDataItem dataItemWithX:x y:y xLabel:labelX dataLabel:labelY];
                        };
                    }
                    [chartSeries addObject:dx];
                }
                
                // get view size
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                CGFloat screenWidth = screenRect.size.width;
                CGFloat screenHeight = screenRect.size.height;
                CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
                
                // margin
                float yRange = yMax - yMin;
                float yMinMargin = yRange * 0.05;
                float yMaxMargin = yRange * 0.15;
                
                LCLineChartView *chartView = [[LCLineChartView alloc] initWithFrame:CGRectMake(0, (navHeight + 20), screenWidth, screenHeight - (navHeight + 20))];
                
                chartView.yMin = yMin - yMinMargin;
                chartView.yMax = yMax + yMaxMargin;
                
                // 6 labels for y axis
                chartView.ySteps = @[[NSString stringWithFormat:@"%.f", chartView.yMin],
                                     [NSString stringWithFormat:@"%.f", chartView.yMin + (chartView.yMax-chartView.yMin)*(1.0/5.0)],
                                     [NSString stringWithFormat:@"%.f", chartView.yMin + (chartView.yMax-chartView.yMin)*(2.0/5.0)],
                                     [NSString stringWithFormat:@"%.f", chartView.yMin + (chartView.yMax-chartView.yMin)*(3.0/5.0)],
                                     [NSString stringWithFormat:@"%.f", chartView.yMin + (chartView.yMax-chartView.yMin)*(4.0/5.0)],
                                     [NSString stringWithFormat:@"%.f", chartView.yMax]];
                chartView.data = chartSeries;
                
                for(UIView *subView in self.view.subviews) {
                    [subView removeFromSuperview];
                }
                [self.view addSubview:chartView];
                
                // loop loading chart
                if([[NSUserDefaults standardUserDefaults] boolForKey:REFRESH_CHARTS]) {
                    float delay = lroundf([[NSUserDefaults standardUserDefaults] floatForKey:REFRESH_CHARTS_TIMEOUT]);
                    [self performSelector:@selector(loadChart) withObject:nil afterDelay:delay];
                }
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No series to plot" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load chart error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

@end
