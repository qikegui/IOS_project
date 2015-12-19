//
//  LoadImage.h
//  PhotoKit
//
//  Created by qkg on 15/12/19.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <paths.h>
#import <Photos/Photos.h>
@import Photos;

@protocol LoadImageDelegate <NSObject>

-(void)getImageArray:(NSArray *)imageArray;

@optional
-(void)loadingImageError:(NSString *)error;

-(void)loadingImageStatus:(NSString *)status currentIndexs:(NSInteger)index;

@end

@interface LoadImage : NSObject

{
    dispatch_group_t _group;
}

@property (nonatomic,assign) NSInteger startIndex; //location

@property (nonatomic,assign) NSInteger lenght;  // 取照片的数量

@property (nonatomic,retain,readonly) NSMutableArray * imageArray; // 返回的image 源

@property (nonatomic,retain,readonly) NSMutableArray * imageUrlArray;  // 返回的imageurl

@property (nonatomic,assign) id<LoadImageDelegate> delegate;

-(instancetype)initWithImageCount:(NSInteger)startIndex len:(NSUInteger)lenght;

+(instancetype)LoadingImageFromPhoneMemory:(NSInteger)startIndex len:(NSInteger)lenght;

-(void)LoadingImage:(NSInteger)startIndex len:(NSInteger)lenght;

@end
