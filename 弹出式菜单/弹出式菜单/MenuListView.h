//
//  MenuListView.h
//  弹出式菜单
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIMenuListViewDelegate <NSObject>

@optional
- (void)menuListBackValue:(NSString *)value;

@end

@interface MenuListView : UIView <UITableViewDataSource,UITableViewDelegate>

{

    UITableView * tableView;
}

@property (nonatomic,strong) NSMutableArray * source;

@property (nonatomic,strong) UITextField * textfiled;

@property (nonatomic,assign) id<UIMenuListViewDelegate> delegate;


@end
