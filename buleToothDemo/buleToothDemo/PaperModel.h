//
//  PaperModel.h
//  BluePrint_Demo
//
//  Created by qkg on 15/12/23.
//  Copyright © 2015年 Eric周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaperModel : NSObject

@property (nonatomic,copy) NSString * titile;

@property (nonatomic,copy) NSString * whoPrinter;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * goods;
@property (nonatomic,copy) NSString * number;
@property (nonatomic,copy) NSString * userCardNumber;
@property (nonatomic,copy) NSString * orderID;
@property (nonatomic,copy) NSString * tradingTime;
@property (nonatomic,copy) NSString * tradingPrice;
@property (nonatomic,copy) NSString * printerTime;

@property (nonatomic,copy) NSString * desc;

@property (nonatomic,retain) NSMutableArray * propertyArray;

-(instancetype)initWithPrinterInfo:(NSString*)name
                             goods:(NSString*)goods
                            number:(NSString*)num
                              card:(NSString*)userNumber
                           orderID:(NSString*)orderID
                       tradingTime:(NSString*)time
                      tradingPrice:(NSString*)price;



@end
