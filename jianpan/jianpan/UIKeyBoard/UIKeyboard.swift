//
//  UIKeyboard.swift
//  jianpan
//
//  Created by qkg on 15/10/26.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit
let KScreen_Width = UIScreen.mainScreen().bounds.width
let KScreen_Hight = UIScreen.mainScreen().bounds.height
@objc protocol UIKeyboardDelegate : NSObjectProtocol {
    
    optional func keyBoardValue(value:String)
}

class UIKeyboard: UIView ,UITextFieldDelegate{
    var delegate : UIKeyboardDelegate!
    var textField : UITextField {
        willSet{
            self.textField = newValue
            self.textField.delegate = self
            self.textField.inputView = self
        }
    }
    override init(frame: CGRect) {
        textField = UITextField()
        super.init(frame: frame)
        setUpView()
        self.backgroundColor = UIColor.blackColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func returnKeyBoard() -> UIKeyboard {
        
        let keyBoard = UIKeyboard(frame: CGRectMake(0,0,KScreen_Width,160))
        return keyBoard
    }
    
    func setUpView() {
        let titleArray : [String] = ["1","2","3","4","5","6","7","8","9",".","0","x"]
        var j = 0
        var h = 0
        for i in 0 ..< 12 {
            
            if i%3 == 0 && i != 0 {
                j++;
                h = 0
            }
            
            let button = KeyBoardButton(frame: CGRectMake(KScreen_Width/3*CGFloat(h),40*CGFloat(j),KScreen_Width/3,40))
            button.setTitle(titleArray[i], forState: UIControlState.Normal)
            button.tag = 300 + i
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            h++
        }
    }
    
    func buttonAction(sender:UIButton) {
        makeInfo(sender)
    }
    
    func makeInfo(sender:UIButton) {
        
        var str : String = ""
        
        if sender.tag - 300 == 9 {
            str = "."
        }else if sender.tag - 300 == 11 {
            str = ""
            self.deleteKeyBoardOneStringToTextField()
            return
        }else{
            str = "\(sender.titleLabel!.text!)"
        }
        
        if delegate != nil {
            if self.delegate.respondsToSelector("keyBoardValue:") {
                self.delegate.keyBoardValue?(str)
                self.appendContentToTextField(str)
            }
        }else{
            self.appendContentToTextField(str)
        }
    }
    
    
    //键盘推出的是自己。。
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.inputView = self
    }
    
    func deleteKeyBoardOneStringToTextField() {
        let source : NSMutableString = NSMutableString(string: self.textField.text!)
        
        if source.length != 0 {
            let textRange : UITextRange = self.textField.selectedTextRange!
            
            var offset = self.textField.offsetFromPosition(textRange.start, toPosition: textRange.end)
            offset = source.length
            if offset != 0 {
                let backWord : NSRange = NSMakeRange(offset - 1, 1)
                source.deleteCharactersInRange(backWord)
                self.textField.text = source as String
                let newPost : UITextPosition = self.textField.positionFromPosition(self.textField.beginningOfDocument, offset: offset-1)!
                self.textField.selectedTextRange = self.textField.textRangeFromPosition(newPost, toPosition: newPost)
            }
        }
    }
    
    func appendContentToTextField(appendString:String) {
        let contentString = NSMutableString(string: self.textField.text!)
        let textRange : UITextRange = self.textField.selectedTextRange!
        var offset = self.textField.offsetFromPosition(textRange.start, toPosition: textRange.end)
        offset = contentString.length
        
        contentString.insertString(appendString, atIndex: offset)
        
        self.textField.text = contentString as String
        let newPost : UITextPosition = self.textField.positionFromPosition(self.textField.beginningOfDocument, offset: offset+1)!
        self.textField.selectedTextRange = self.textField.textRangeFromPosition(newPost, toPosition: newPost)
        
    }

}
