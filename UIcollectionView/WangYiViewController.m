//
//  WangYiViewController.m
//  UIcollectionView
//
//  Created by 陈思远 on 16/4/19.
//  Copyright © 2016年 陈思远. All rights reserved.
//

#import "WangYiViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
@interface WangYiViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WangYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    UIView *lastView;
    CGFloat weight = 55;
    
    UIView* contentView = UIView.new;
    [self.WangYiScrollview addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.WangYiScrollview);
        make.height.equalTo(self.WangYiScrollview);
    }];
    
    for (int i =1 ; i<=array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [self randomColor];
        label.text = [NSString stringWithFormat:@"%d",i];
        [contentView addSubview:label];        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(contentView);
            make.top.equalTo(@0);
            //make.bottom.equalTo(@0);
            make.left.equalTo(lastView ? lastView.right : @0);
            make.width.equalTo(weight);
        }];
        lastView = label;
    }
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.right);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)self.navigationController.interactivePopGestureRecognizer;

    [_WangYiScrollview.panGestureRecognizer requireGestureRecognizerToFail:screenEdgePanGestureRecognizer];
   // [_WangYiScrollview.panGestureRecognizer requireGestureRecognizerToFail:[self screenEdgePanGestureRecognizer]];
}

- (UIPanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIPanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.navigationController.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.navigationController.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIPanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    
    return screenEdgePanGestureRecognizer;
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}




- (void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];
    
    NSLog(@"即将消失 ");
    if (![[self.navigationController viewControllers] containsObject: self])
    {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
    }
}


- (void)viewDidDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];
    
    NSLog(@"消失 ");
    if (![[self.navigationController viewControllers] containsObject: self])
    {
        
    }
}

@end
