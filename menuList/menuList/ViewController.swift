//
//  ViewController.swift
//  menuList
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIMenuListViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let source = ["Jordan","Kobe","Ronaldo","Modric","Bale"]
        let textField2 = menuListView(frame: CGRectMake(10,100,280,44))
        textField2.source = source
        textField2.backgroundColor = UIColor.redColor()
        textField2.delegate = self
        self.view.addSubview(textField2)
        
        let source2 = ["Real Madrid","Barcelona","Bayern Munich","Manchester united","Chelsea"]
        let textField3 = menuListView(frame: CGRectMake(10,200,280,44))
        textField3.source = source2
        textField3.backgroundColor = UIColor.redColor()
        textField3.delegate = self
        self.view.addSubview(textField3)
    }
    
    func menuListViewBackIndexValue(index: Int) {
        print(index)
    }
    func menuListViewBackStringValue(info: String) {
        print(info)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

