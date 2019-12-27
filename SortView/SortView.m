//
//  SortView.m
//  SortView
//
//  Created by WeiHan on 10/6/14.
//  Copyright (c) 2014 Wei Han. All rights reserved.
//

#import "SortView.h"

#define kTableCellHeight    30

@interface SortView()
{
    UIButton *titleView;
    UITableView *myTableView;
    
    BOOL isExpand;
    CGSize expandedSize;
    
    NSMutableArray *tableViewDataSource;
}

@end

@implementation SortView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor lightGrayColor];
        
        titleViewHeight = 50;
        titleViewMargin = 30;
        
        isExpand = YES;
        
        titleView = [UIButton buttonWithType:UIButtonTypeSystem];
        myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        
    }
    return self;
}

- (void)layoutSubviews
{
    titleView.frame = CGRectMake(0, 0, self.frame.size.width, titleViewHeight);
    titleView.backgroundColor = [UIColor grayColor];
    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleView addTarget:self action:@selector(clickTitleView) forControlEvents:UIControlEventTouchUpInside];
    
    myTableView.frame = CGRectMake(0,
                                 titleView.frame.size.height + titleViewMargin,
                                 self.frame.size.width,
                                 self.frame.size.height - titleViewMargin - titleView.frame.origin.y - titleViewHeight);
    myTableView.scrollEnabled = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor grayColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    [self addSubview:titleView];
    [self addSubview:myTableView];
}

- (void)setDataSource:(NSArray *)dataSource
{
    if (titleView)
    {
        [titleView setTitle:dataSource[0] forState:UIControlStateNormal];
    }
    
    CGRect frame = myTableView.frame;
    myTableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kTableCellHeight * dataSource.count);
    expandedSize = CGSizeMake(frame.size.width, frame.size.height);
    
    NSArray *arr = [dataSource subarrayWithRange:NSMakeRange(1, dataSource.count - 1)];
    tableViewDataSource = [NSMutableArray arrayWithArray:arr];
    [myTableView reloadData];
}

- (void)clickTitleView
{
    isExpand = !isExpand;
    [self shouldExpandTable:isExpand];
}

- (void)shouldExpandTable:(BOOL)flag
{
    if (flag)
    {
        self.clipsToBounds = NO;
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                expandedSize.width,
                                expandedSize.height);
    }
    else
    {
        self.clipsToBounds = YES;
        
//        if (CGSizeEqualToSize(expandedSize, CGSizeZero))
//            expandedSize = myTableView.frame.size;
        
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                titleView.frame.origin.y + titleView.frame.size.width,
                                titleView.frame.origin.x + titleView.frame.size.height);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"kSortViewTableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [tableViewDataSource[indexPath.row] description];
    
    return cell;
}


#pragma mark - UITableViewDelegate


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedText = tableViewDataSource[indexPath.row];
    NSString *titleText = titleView.titleLabel.text;
    [titleView setTitle:selectedText forState:UIControlStateNormal];
    
    [tableViewDataSource removeObjectAtIndex:indexPath.row];
    [tableViewDataSource insertObject:titleText atIndex:0];
    [tableViewDataSource insertObject:selectedText atIndex:0];
    
    [self setDataSource:tableViewDataSource];
    [self clickTitleView];
    
    if (self.switchedBlock)
    {
        self.switchedBlock(selectedText);
    }
}

@end
