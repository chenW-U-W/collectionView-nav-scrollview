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
#import "LFirstViewController.h"
#import "LSecondViewController.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
@interface WangYiViewController ()<UIGestureRecognizerDelegate>
{
    UILabel *previousLabel;
    LSecondViewController *LsecondVC;
    LFirstViewController *LFirstVC;
    NSInteger currentTag;
}
@property(nonatomic,strong)UIViewController *currentVC;
@end

@implementation WangYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentTag = 1;
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
        label.tag = i;
        label.backgroundColor = [self randomColor];
        label.text = [NSString stringWithFormat:@"%d",i];
        [contentView addSubview:label];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tapGesture];
        
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
    
    LFirstVC = [[LFirstViewController alloc] init];
    [self addChildViewController:LFirstVC];
    [self.view addSubview:LFirstVC.view];
    [LFirstVC.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_WangYiScrollview.bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    self.currentVC = LFirstVC;
    UILabel *label1 = [_WangYiScrollview viewWithTag:1];
    previousLabel = label1;
    
    
    LsecondVC = [[LSecondViewController alloc] init];
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

- (void)tapClick:(UIGestureRecognizer *)gesture
{
    NSLog(@"tapClick");
    UIView *view = gesture.view;
    [previousLabel setBackgroundColor:[UIColor redColor]];
    UILabel *currentLabel  =(UILabel *)[gesture view];
    currentLabel.backgroundColor = [UIColor orangeColor];
    previousLabel = currentLabel;
    
    /**
     *  在iOS5中，ViewController中新添加了下面几个方法：
     *  addChildViewController:
     *  removeFromParentViewController
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  willMoveToParentViewController:
     *  didMoveToParentViewController:
     */
    
    if (currentTag == view.tag) {
        return;
    }
    else
    {
        if (view.tag == 2) {
            
            [self addChildViewController:LsecondVC];
            [self transitionFromViewController:self.currentVC toViewController:LsecondVC duration:2.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                if (finished) {
                    [self.currentVC removeFromParentViewController];
                }else{
                }
            }];
            
            [LsecondVC.view makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_WangYiScrollview.bottom);
                make.left.equalTo(@0);
                make.right.equalTo(@0);
                make.bottom.equalTo(@0);
            }];
            self.currentVC = LsecondVC;
        }
        if (view.tag == 1) {
            
            [self addChildViewController:LFirstVC];
            [self transitionFromViewController:self.currentVC toViewController:LFirstVC duration:2.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                if (finished) {
                    [self.currentVC removeFromParentViewController];
                }else{
                }
            }];
            
            [LFirstVC.view makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_WangYiScrollview.bottom);
                make.left.equalTo(@0);
                make.right.equalTo(@0);
                make.bottom.equalTo(@0);
            }];
            
            self.currentVC = LFirstVC;
        }
        
    }
    currentTag = view.tag;
    
}

@end
