//
//  NTChartViewController.m
//  DSAHQChartDemo
//
//  Created by JinYong on 15-1-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NTChartViewController.h"
#import "NTChartView.h"

#define SUM_GROUP   (3)
#define SUM_CELL    (7)
#define SUM_CELL2   (12)
@interface NTChartViewController ()

@end

@implementation NTChartViewController

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
    self.title = @"竖状图";
    
    NTChartView *v = [[NTChartView alloc] initWithFrame:CGRectMake(10, 10, 1000, 350)];
    v.chartType = 0;//并列显示
    v.chartTitle = @[@"并列数据表展示"];
    
    NSMutableArray *g = [NSMutableArray array];
    for (int i=0; i<SUM_GROUP; i++) {
        NSMutableArray *arrCell = [[NSMutableArray alloc] init];
        for (int j=0; j<SUM_CELL; j++) {
            NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
            [arrCell addObject:one];
        }
        [g addObject:arrCell];
        [arrCell release];
    }
    v.groupData = g;
    
    v.xAxisLabel = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07"];
    
    v.backgroundColor = [UIColor clearColor];
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:v];
    
    
    NTChartView *v2 = [[NTChartView alloc] initWithFrame:CGRectMake(10, 380, 1000, 350)];
    v2.chartType = 1;//重叠显示
    
    v2.chartTitle = @[@"重叠数据表显示"];
    
    NSMutableArray *g2 = [NSMutableArray array];
    for (int i=0; i<SUM_GROUP; i++) {
        NSMutableArray *arrCell = [[NSMutableArray alloc] init];
        for (int j=0; j<SUM_CELL2; j++) {
            NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
            [arrCell addObject:one];
        }
        [g2 addObject:arrCell];
        [arrCell release];
    }
    v2.groupData = g2;
    
//    NSArray *gt2 = [NSArray arrayWithObjects:@"xxx",@"yyy", nil];
//    v2.groupTitle = gt2;
    
    v2.xAxisLabel = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    v2.backgroundColor = [UIColor clearColor];
    v2.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:v2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
@end
