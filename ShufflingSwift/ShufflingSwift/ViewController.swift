//
//  ViewController.swift
//  ShufflingSwift
//
//  Created by qkg on 15/11/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageArray = ["2.png","3.png"]
        let shuff = ShufflingView(frame: CGRectMake(0,100,320,150))
        shuff.locationImageArray = imageArray
        //shuff.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(shuff)
        
        let urlImage = ["https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg", "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg","http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]
        
        let shuff1 = ShufflingView.ShufflingWithUrlArray(CGRectMake(0,260,320,100), urlImageArray: urlImage)//ShufflingWithLocationArray(CGRectMake(0,260,320,100), locationArray: urlImage)
        shuff1.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(shuff1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

