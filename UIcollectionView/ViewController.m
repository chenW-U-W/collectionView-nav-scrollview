//
//  ViewController.m
//  UIcollectionView
//
//  Created by 陈思远 on 16/4/13.
//  Copyright © 2016年 陈思远. All rights reserved.
//

#import "ViewController.h"
#import "WangYiRootViewController.h"
#import "WangYiViewController.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    UICollectionView *_collectionView;
    id target;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)  collectionViewLayout:flowLayout];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    self.navigationController.navigationBar.translucent = NO;
    
    //self.navigationItem.prompt = @"这是说明";
     self.navigationItem.title = @"这是标题";
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doIt)];
    btnItem.width = 10;
    self.navigationItem.leftBarButtonItem = btnItem;
    
    
 //  UINavigationController
    
    target = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.delegate = self;
   
    
    
    
    
    
}

-(void)purchase:(id)sender
{

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%ld",(long)indexPath.item);
    NSLog(@"row=======%ld",(long)indexPath.row);
    NSLog(@"section===%ld",(long)indexPath.section);
    
   WangYiViewController  *oneVC = [[WangYiViewController alloc] init];
//    [self presentViewController:oneVC animated:YES completion:^{
//        
//    }];
//    [self.view addSubview:oneVC.view];
    [self.navigationController pushViewController:oneVC animated:YES];
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}



//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//在下一级视图viewdidload 之后 viewdidappear之前调用
- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    
        if ([self.navigationController.viewControllers count] == 2) {
            
          if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            [self addGesture:@selector(handleNavigationTransition:)];
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
             //self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
        else {
            
            self.navigationController.interactivePopGestureRecognizer.delegate = target;
        }

}

- (void)addGesture:(SEL)action
{
//    UIScreenEdgePanGestureRecognizer *gesture = (UIScreenEdgePanGestureRecognizer *)self.navigationController.interactivePopGestureRecognizer;
//    gesture.enabled  = NO;
//    NSMutableArray *targets = [gesture valueForKeyPath:@"_targets"];
//    id gestureTarget = [targets firstObject];
//    id target1 = [gestureTarget valueForKeyPath:@"_target"];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target1 action:action];
//    [gesture.view addGestureRecognizer:pan];
//    NSLog(@"%@",gesture.view);
}


@end
