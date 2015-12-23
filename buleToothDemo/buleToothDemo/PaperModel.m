//
//  PaperModel.m
//  BluePrint_Demo
//
//  Created by qkg on 15/12/23.
//  Copyright © 2015年 Eric周. All rights reserved.
//

#import "PaperModel.h"

@implementation PaperModel

-(instancetype)initWithPrinterInfo:(NSString*)name
                             goods:(NSString*)goods
                            number:(NSString*)num
                              card:(NSString*)userNumber
                           orderID:(NSString*)orderID
                       tradingTime:(NSString*)time
                      tradingPrice:(NSString*)price{
    if (self=[super init]) {
        self.propertyArray = [NSMutableArray array];
        [self initInfo:name goods:goods number:num card:userNumber orderID:orderID tradingTime:time tradingPrice:price];
    }
    
    return self;
}
-(void)initInfo:(NSString*)name
          goods:(NSString*)goods
         number:(NSString*)num
           card:(NSString*)userNumber
        orderID:(NSString*)orderID
    tradingTime:(NSString*)time
   tradingPrice:(NSString*)price{
    
    self.titile         = [NSString stringWithFormat:@" 驾车宝签购单         \n"];
    [self.propertyArray addObject:self.titile];
    NSString *line1     = [NSString stringWithFormat:@"-----------------------\n"];
    [self.propertyArray addObject:line1];
    self.whoPrinter     = [NSString stringWithFormat:@"       收银员联      \n"];
    [self.propertyArray addObject:self.whoPrinter];
    NSString *line2     = [NSString stringWithFormat:@"-----------------------\n"];
    [self.propertyArray addObject:line2];
    self.name           = [NSString stringWithFormat:@"商户名称:    %@\n",name];
    [self.propertyArray addObject:self.name];
    self.goods          = [NSString stringWithFormat:@"商品名称:    %@\n",goods];
    [self.propertyArray addObject:self.goods];
    self.number         = [NSString stringWithFormat:@"商户编码:    %@\n",num];
    [self.propertyArray addObject:self.number];
    NSString *line3     = [NSString stringWithFormat:@"-----------------------\n"];
    [self.propertyArray addObject:line3];
    self.userCardNumber = [NSString stringWithFormat:@"用户卡号:    %@\n",userNumber];
    [self.propertyArray addObject:self.userCardNumber];
    self.orderID        = [NSString stringWithFormat:@"订单编号:    %@\n",orderID];
    [self.propertyArray addObject:self.orderID];
    self.tradingTime    = [NSString stringWithFormat:@"交易时间:    %@\n",time];
    [self.propertyArray addObject:self.tradingTime];
    self.tradingPrice   = [NSString stringWithFormat:@"交易金额:    %@\n",price];
    [self.propertyArray addObject:self.tradingPrice];
    NSString *line4     = [NSString stringWithFormat:@"-----------------------\n"];
    [self.propertyArray addObject:line4];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSString *current   = [NSString stringWithFormat:@"打印时间:    %@\n",dateString];
    [self.propertyArray addObject:current];
    
    self.desc = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@",self.titile,line1,self.whoPrinter,line2,self.name,self.goods,self.number,line3,self.userCardNumber,self.orderID,self.tradingTime,self.tradingPrice,line4,current];

}

-(NSString *)description{
    
    return self.desc;
}

@end
