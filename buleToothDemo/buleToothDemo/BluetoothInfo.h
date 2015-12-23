//
//  BluetoothInfo.h
//  buleToothDemo
//
//  Created by qkg on 15/12/23.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface BluetoothInfo : NSObject

@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;
@property (nonatomic, strong) NSNumber *rssi;

@end
