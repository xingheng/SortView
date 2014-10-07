//
//  MyViewController.m
//  SortView
//
//  Created by WeiHan on 10/6/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import "MyViewController.h"
#import "SortView.h"

@interface MyViewController()

@end

@implementation MyViewController

- (id)init
{
    if (self = [super init])
    {
     
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    SortView *sortview = [[SortView alloc] initWithFrame:CGRectMake(60, 80, 200, 300)];
    [sortview setDataSource:@[@"A", @"B", @"C", @"D"]];
    [sortview setSwitchedBlock:^(id object) {
        NSLog(@"%@", object);
    }];
    [self.view addSubview:sortview];
}

@end
