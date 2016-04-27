//
//  WangYiRootViewController.m
//  UIcollectionView
//
//  Created by 陈思远 on 16/4/19.
//  Copyright © 2016年 陈思远. All rights reserved.
//

#import "WangYiRootViewController.h"
#import "WangYiViewController.h"
#import "Masonry.h"
@interface WangYiRootViewController ()
{
    UINavigationController  *nav;
}
@end

@implementation WangYiRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WangYiViewController *wangyiVC = [[WangYiViewController alloc] init] ;
    nav = [[UINavigationController alloc] initWithRootViewController:wangyiVC];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = [UIColor greenColor];
    nav.navigationBarHidden=YES;
    //[self.view insertSubview:nav.view atIndex:0];
    [self.view addSubview:nav.view];
    NSLog(@"%@",NSStringFromCGRect(nav.view.frame));
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
