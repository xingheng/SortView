//
//  SortView.h
//  SortView
//
//  Created by WeiHan on 10/6/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NewItemSwitchedBlock)(id object);

@interface SortView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat titleViewHeight;
    CGFloat titleViewMargin;
}

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NewItemSwitchedBlock switchedBlock;

@end
