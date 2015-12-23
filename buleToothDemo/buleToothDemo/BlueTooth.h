//
//  BlueTooth.h
//  buleToothDemo
//
//  Created by qkg on 15/12/22.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class CBCentralManager;
@class PaperModel;
@protocol BuleToothDelegate <NSObject>

@optional

-(void)startSacanner:(NSString *)state;

-(void)scannerState:(NSString *)state;

-(void)connectState:(NSString *)state;

-(void)printerState:(NSString *)state;

@end
@interface BlueTooth : NSObject

@property (nonatomic,strong) CBCentralManager *manager;

@property (nonatomic,strong) NSMutableArray * perpheralArray;

@property (nonatomic,assign) id<BuleToothDelegate> delegate;

-(instancetype)initWithDelegate:(id<BuleToothDelegate>)delegate;

-(BOOL)connectWithUUID:(CBPeripheral *)peripheral;

-(void)printerText:(PaperModel *)printerInfo;

@end
