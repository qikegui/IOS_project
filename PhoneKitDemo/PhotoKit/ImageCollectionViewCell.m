//
//  ImageCollectionViewCell.m
//  PhotoKit
//
//  Created by qkg on 15/12/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUpView{
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.imageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.imageView];
}

-(void)imageWithImage:(UIImage *)image{
    self.imageView.image = image;
}

@end
