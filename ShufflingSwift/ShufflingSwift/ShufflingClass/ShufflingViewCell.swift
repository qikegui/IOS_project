//
//  ShufflingViewCell.swift
//  ShufflingSwift
//
//  Created by qkg on 15/11/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ShufflingViewCell: UICollectionViewCell {

    var image:UIImageView!
    var titleLabel:UILabel!
    var pageControl:UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        
        self.image = UIImageView()
        self.addSubview(self.image)
        
        self.titleLabel = UILabel()
        self.image.addSubview(titleLabel)
        
        self.pageControl = UIPageControl()
        self.pageControl.backgroundColor = UIColor.clearColor()
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        self.image.addSubview(self.pageControl)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.image.frame = self.bounds;
        self.titleLabel.frame = CGRectMake(0, self.frame.size.height-21, self.frame.size.width, 21);
        self.pageControl.frame = CGRectMake(0, self.frame.size.height-21, self.frame.size.width, 21);
    }
    
    
    
    
    
}
