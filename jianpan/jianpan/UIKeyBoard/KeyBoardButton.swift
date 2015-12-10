//
//  KeyBoardButton.swift
//  jianpan
//
//  Created by qkg on 15/10/27.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class KeyBoardButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var topLine : UIView!
    var leftLine : UIView!
    var downLine : UIView!
    var RightLine : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textColor = UIColor.blackColor()
        self.backgroundColor = UIColor.lightTextColor()
        self._initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        let Width = self.frame.size.width
        let Hight = self.frame.size.height
        self.topLine = UIView(frame: CGRectMake(0,0,Width,1))
        self.topLine.backgroundColor = UIColor.lightTextColor()
        self.addSubview(topLine)
        self.leftLine = UIView(frame: CGRectMake(0,0,1,Hight))
        self.leftLine.backgroundColor = UIColor.lightTextColor()
        self.addSubview(leftLine)
        self.downLine = UIView(frame: CGRectMake(0,Hight-1,Width,1))
        self.downLine.backgroundColor = UIColor.lightTextColor()
        self.addSubview(downLine)
        
        self.RightLine = UIView(frame: CGRectMake(Width-1,0,1,Hight))
        self.RightLine.backgroundColor = UIColor.lightTextColor()
        self.addSubview(RightLine)
    }

}
