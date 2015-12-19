//
//  NSObject+CompressImage.h
//  PhotoKit
//
//  Created by qkg on 15/12/19.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSObject (CompressImage)

//压缩图片 ---- 会出现失真---
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//截取图片
-(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;

@end
