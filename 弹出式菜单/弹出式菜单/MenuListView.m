//
//  MenuListView.m
//  弹出式菜单
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "MenuListView.h"
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation MenuListView
@synthesize source = _source;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if  (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 280)];
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = footerView;
    
    self.textfiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.textfiled.inputView = tableView;
    [self addSubview:self.textfiled];
    
}

-(void)setSource:(NSMutableArray *)source{
    _source = source;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil ) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    if (self.source.count>0) {
        
        cell.textLabel.text = self.source[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate != nil ) {
        
        if ([self.delegate respondsToSelector:@selector(menuListBackValue:)]){
            [self.delegate menuListBackValue:self.source[indexPath.row]];
        }
        
    }
    self.textfiled.text = self.source[indexPath.row];
    [self.textfiled resignFirstResponder];
}


@end
