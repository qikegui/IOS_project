//
//  ViewController.swift
//  色值转换器
//
//  Created by qkg on 15/12/9.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.colorview.backgroundColor = UIColor.colorWithString("#FFC0CB")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

