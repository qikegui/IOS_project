//
//  ImageCollectionViewCell.h
//  PhotoKit
//
//  Created by qkg on 15/12/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * imageView;

-(void)imageWithImage:(UIImage *)image;

@end
