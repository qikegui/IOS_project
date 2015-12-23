//
//  ViewController.m
//  buleToothDemo
//
//  Created by qkg on 15/12/22.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueTooth.h"
#import "BluetoothInfo.h"
#import "PaperModel.h"
@interface ViewController () <BuleToothDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) CBCentralManager *manager;

@property (nonatomic,strong) CBPeripheral * peripheral;

@property (weak, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) BlueTooth * bule;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.bule = [[BlueTooth alloc]initWithDelegate:self];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.bule.perpheralArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    BluetoothInfo *info = self.bule.perpheralArray[indexPath.row];
    
    cell.textLabel.text = info.discoveredPeripheral.name;
    cell.detailTextLabel.text = info.discoveredPeripheral.identifier.description;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BluetoothInfo *info = self.bule.perpheralArray[indexPath.row];
    [self.bule connectWithUUID:info.discoveredPeripheral];
}


- (IBAction)scanSever:(id)sender {

    NSLog(@"开始扫描蓝牙设备");
}
- (IBAction)connet:(id)sender {
    
    PaperModel * printer = [[PaperModel alloc]initWithPrinterInfo:@"嘻嘻嘻嘻嘻嘻"goods:@"QQ会员一年" number:@"暂无" card:@"13313971076" orderID:@"928u3432i48932e32h" tradingTime:@"2015/4/3" tradingPrice:@"100万"];
    [self.bule printerText:printer];
}

-(void)scannerState:(NSString *)state{
    
    NSLog(@"%@",state);
    
    [self.tableView reloadData];
}

-(void)connectState:(NSString *)state{
    NSLog(@"%@",state);
}

-(void)printerState:(NSString *)state{
    NSLog(@"%@",state);
}


-(void)upstatus:(NSString *)str{
    self.content.text = [NSString stringWithFormat:@"%@\n",str];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.content resignFirstResponder];
}

@end
