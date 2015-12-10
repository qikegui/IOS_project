//
//  ViewController.m
//  弹出式菜单
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "ViewController.h"
#import "MenuListView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *name = @[@"Real Madrid",@"Barcelona",@"Bayern Munich",@"Manchester united",@"Chelsea"];
    
    MenuListView *nameView = [[MenuListView alloc]initWithFrame:CGRectMake(10, 100, 280, 44)];
    nameView.source = name.mutableCopy;
    nameView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:nameView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
