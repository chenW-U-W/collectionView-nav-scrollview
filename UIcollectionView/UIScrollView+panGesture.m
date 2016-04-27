//
//  UIScrollView+panGesture.m
//  UIcollectionView
//
//  Created by 陈思远 on 16/4/27.
//  Copyright © 2016年 陈思远. All rights reserved.
//

#import "UIScrollView+panGesture.h"

@implementation UIScrollView (panGesture)
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
