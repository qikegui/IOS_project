//
//  LoadImage.m
//  PhotoKit
//
//  Created by qkg on 15/12/19.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "LoadImage.h"


#define MAXREQUESTINSEXS 10 //最大加载次数----

typedef NS_ENUM(NSInteger,LoadingImageResult)  {
    
    failure = 0, //读取图片失败----
    succeed      // 成功-------
};

@interface LoadImage ()

@property (nonatomic,retain) NSTimer * timer;

@property (nonatomic,assign) NSTimeInterval interval;

@property (nonatomic,assign) NSInteger currentIndexs;

@end


@implementation LoadImage

-(instancetype)initWithImageCount:(NSInteger)startIndex len:(NSUInteger)lenght{
    
    self = [super init];
    if (self) {
        _startIndex = startIndex;
        _lenght = lenght+startIndex;
        _imageArray = [NSMutableArray array];
        _imageUrlArray = [NSMutableArray array];
        _group = dispatch_group_create();
        self.interval = 2;
        self.currentIndexs = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(startLoaingImage) userInfo:nil repeats:true];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

+(instancetype)LoadingImageFromPhoneMemory:(NSInteger)startIndex len:(NSInteger)lenght{
    return [[self alloc]initWithImageCount:startIndex len:lenght];
}

-(void)LoadingImage:(NSInteger)startIndex len:(NSInteger)lenght{
    
    self.startIndex = startIndex;
    self.lenght = lenght+startIndex;
    [self startLoaingImage];
}

-(void)creatLoadingImageQueue {
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    dispatch_group_async(_group, q, ^{
        @synchronized(weakSelf) {
            [weakSelf makeData];
        }
        
    });
}

-(void)startLoaingImage{
    
    if (self.currentIndexs == MAXREQUESTINSEXS) {
        [self.timer invalidate];
        self.currentIndexs = 0;
        if ([self.delegate respondsToSelector:@selector(loadingImageError:)]) {
            [self.delegate loadingImageError:@"未获取到相册的权限"];
        }
    }else{
        if (self.imageArray.count == 0) {
            self.currentIndexs++;
            [self creatLoadingImageQueue];
            if ([self.delegate respondsToSelector:@selector(loadingImageStatus: currentIndexs:)]) {
                [self.delegate loadingImageStatus:@"0" currentIndexs:self.currentIndexs];
            }
        }else{
           [self.timer invalidate];
            if (self.delegate != nil) {
                if ([self.delegate respondsToSelector:@selector(getImageArray:)]) {
                    [self.delegate getImageArray:self.imageArray];
                }
            }
        }
    }
    
}

-(void)makeData{
    __weak typeof(self) weakSelf = self;
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        // 获取一个资源（PHAsset）
        PHAsset *asset = assetsFetchResults[i];
        PHContentEditingInputRequestOptions *option = [[PHContentEditingInputRequestOptions alloc]init];
        [asset requestContentEditingInputWithOptions:option completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
            if (weakSelf.imageArray.count == weakSelf.lenght-weakSelf.startIndex) {
                return;
            }
            if (contentEditingInput.displaySizeImage != nil) {
                [weakSelf.imageArray addObject:contentEditingInput.displaySizeImage];
                [weakSelf.imageUrlArray addObject:contentEditingInput.fullSizeImageURL];
            }
        }];
    }
}
@end
