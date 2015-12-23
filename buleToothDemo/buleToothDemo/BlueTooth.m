//
//  BlueTooth.m
//  buleToothDemo
//
//  Created by qkg on 15/12/22.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "BlueTooth.h"
#import "BluetoothInfo.h"
#import "PaperModel.h"
#define kServiceUUID @"18F0"
#define kCharacteristicUUID @"2AF1"
@interface BlueTooth () <CBCentralManagerDelegate ,CBPeripheralDelegate>

@property (nonatomic,copy) NSString * messageStatus;

@property (nonatomic,strong) NSMutableArray * severArray;

@property (nonatomic,copy) NSString * messageState;

@property (nonatomic,strong) NSMutableArray * cbSever;

@property (nonatomic,strong) CBCharacteristic * writeCharacteristic;

@property (nonatomic,strong) CBPeripheral * perpheral;

@end

@implementation BlueTooth

-(instancetype)initWithDelegate:(id<BuleToothDelegate>)delegate{
    
    self = [super init];
    
    if (self) {
        self.delegate = delegate;
        self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
        self.severArray = [NSMutableArray array];
        self.cbSever = [NSMutableArray array];
        self.perpheralArray = [NSMutableArray array];
    }
    
    return self;
}

-(void)startSacnnerBlueTooth{
    
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.manager stopScan];
    });
}

-(void)stopScannerBlueTooth{
    [self.manager stopScan];
}


-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
            [self.manager scanForPeripheralsWithServices:nil options:nil];
            NSLog(@"start  Peripherals");
            break;
        default:
            if ([self.delegate respondsToSelector:@selector(startSacanner:)]) {
                [self.delegate startSacanner:@"蓝牙未打开"];
            }
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSString *str = [NSString stringWithFormat:@"Did discover peripheral. peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.name, advertisementData];
    NSLog(@"设备信息:%@",str);
    
    BluetoothInfo *info = [[BluetoothInfo alloc]init];
    info.discoveredPeripheral = peripheral;
    info.rssi = RSSI;
    [self saveBluetooth:info];
}


-(BOOL)saveBluetooth:(BluetoothInfo *)discoverBlueInfo{
    for (BluetoothInfo *info in self.perpheralArray) {
        if ([info.discoveredPeripheral.identifier.UUIDString isEqualToString:discoverBlueInfo.discoveredPeripheral.identifier.UUIDString]) {
            return NO;
        }
    }
    
    NSLog(@"\nDiscover New Devices!\n");
    NSLog(@"discoverBlueInfo\n UUID：%@\n RSSI:%@\n\n",discoverBlueInfo.discoveredPeripheral.identifier.UUIDString,discoverBlueInfo.rssi);
    [self.perpheralArray addObject:discoverBlueInfo];
    
    if ([self.delegate respondsToSelector:@selector(scannerState:)]) {
        [self.delegate scannerState:@"有可用的设备"];
    }
    
    return YES;
}

//连接指定的设备(单独连接自己打印机的UUID)
-(BOOL)connectWithUUID:(CBPeripheral *)peripheral{
    NSLog(@"connect start");
    [self.manager connectPeripheral:peripheral
                                  options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    
    
    
    return (YES);
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
    NSLog(@"连接成功!!!!!!");
    
    NSLog(@"Did connect to peripheral: %@", peripheral);
    //因为在后面我们要从外设蓝牙那边再获取一些信息，并与之通讯，这些过程会有一些事件可能要处理，所以要给这个外设设置代理，比如
    [peripheral setDelegate:self];
    //查询蓝牙服务
    [peripheral discoverServices:nil];
    
    if ([self.delegate respondsToSelector:@selector(connectState:)]) {
        [self.delegate connectState:@"连接成功"];
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    if (error)
    {
        NSLog(@"无服务 DiscoverServices : %@", [error localizedDescription]);
        return;
    }
    
    NSLog(@"sever =====%lu",peripheral.services.count);
    
    for (CBService* service in peripheral.services){
        //查询服务所带的特征值(我自己打印机的FFE0服务)
        NSLog(@"Service found with UUID: %@", service.UUID);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
            NSLog(@"发现服务>>>服务UUID found with UUID : %@ 描述 des:%@", service.UUID,service.UUID.description);
            [peripheral discoverCharacteristics:nil forService:service];
        }
        
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if (error)
    {
        NSLog(@"didDiscoverCharacteristicsForService error : %@", [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic * characteristic in service.characteristics) {
        NSLog(@"\n>>>\t特征UUID FOUND(in 服务UUID:%@): 数据%@ (data:%@)",service.UUID.description,characteristic.UUID,characteristic.UUID.data);
        
        //假如你和硬件商量好了，某个UUID时写，某个读的，那就不用判断啦
        
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]){
            NSLog(@"监听特征:%@",characteristic);//监听特征
            self.perpheral = peripheral;
            self.writeCharacteristic = characteristic;
            [self.perpheral setNotifyValue:YES forCharacteristic:self.writeCharacteristic];
        }
    }
}

-(void)printerText:(PaperModel *)printerInfo{
    
    for (NSString *str in printerInfo.propertyArray) {
        if ([self writeQueue:str]) {
            
        }else{
            
            if ([self.delegate respondsToSelector:@selector(printerState:)]) {
                [self.delegate printerState:@"已断开连接"];
            }
        }
    }
}

-(BOOL)writeQueue:(NSString*)str{
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [str dataUsingEncoding:gbkEncoding];
    if (self.writeCharacteristic == nil) {
        return NO;
    }else{
        [self.perpheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
        
        return YES;
    }
}


//(发送数据)这时还会触发一个代理事件
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error)
    {
        NSLog(@"发送数据特征值%@时发生错误:%@", characteristic.UUID, [error localizedDescription]);
        return;
    }
}
//处理蓝牙发过来的数据(单打印,这块无用)
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error)
    {
        NSLog(@"更新特征值%@时发生错误:%@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    // 收到数据
    NSLog(@"%@",[self hexadecimalString:characteristic.value]);
}

#pragma mark - NSData and NSString

//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}
//将传入的NSString类型转换成NSData并返回
- (NSData*)dataWithHexstring:(NSString *)hexstring{
    NSData* aData;
    return aData = [hexstring dataUsingEncoding: NSASCIIStringEncoding];
}

@end
