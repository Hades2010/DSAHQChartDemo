//
//  PieViewController.h
//  DSAHQChartDemo
//
//  Created by JinYong on 15-1-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
@interface PieViewController : UIViewController<XYPieChartDataSource,XYPieChartDelegate>
@property(nonatomic, retain) IBOutlet XYPieChart *pieChartRight;
@property(nonatomic, retain) IBOutlet XYPieChart *pieChartLeft;
@property(nonatomic, retain) NSMutableArray *slices;
@property(nonatomic, retain) NSArray        *sliceColors;
@property(nonatomic,retain) UIView *coverView;
@end
