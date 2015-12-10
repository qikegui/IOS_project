//
//  ViewController.swift
//  jianpan
//
//  Created by qkg on 15/10/26.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIKeyboardDelegate{

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var test: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        (UIKeyboard.returnKeyBoard() as UIKeyboard).textField = self.textfield
        //(UIKeyboard.returnKeyBoard() as UIKeyboard).textField = self.test
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}

