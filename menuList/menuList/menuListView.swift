//
//  menuListView.swift
//  menuList
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

@objc protocol UIMenuListViewDelegate : NSObjectProtocol {
    
    optional func menuListViewBackIndexValue(index:Int)
    optional func menuListViewBackStringValue(info:String)
}
var menView : menuListView!
let screenWidth = UIScreen.mainScreen().bounds.width
class menuListView: UIView ,UITableViewDataSource,UITableViewDelegate{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var flag = false
    var tableView : UITableView!
    //重写数据元的Set方法。。
    var source : [String] {
        willSet{
            
            self.source = newValue
            self.tableView.delegate = self
            self.tableView.dataSource = self

            self.tableView.reloadData()
            
        }
    }
    var contentTextField : UITextField! /*{
        willSet {
            self.contentTextField = newValue
            self.contentTextField.inputView = self
            self.flag = true
            
        }
    }
*/
    var delegate : UIMenuListViewDelegate!
    override init(frame: CGRect) {
        self.source = []
        //contentTextField = UITextField()
        super.init(frame: frame)
        _initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        
        self.tableView = UITableView(frame: CGRectMake(0,0,screenWidth,280))
        self.tableView.backgroundColor = UIColor.whiteColor()
        let backView = UIView()
        backView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = backView
        self.contentTextField = UITextField(frame: CGRectMake(0,0,self.frame.size.width,self.frame.height))
        self.contentTextField.inputView = self.tableView
        self.addSubview(contentTextField)

    }
    
    func removeViews() {
        
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    class func returnAMenuListView() -> menuListView! {
    
        if let this = menView {
            menView = this
        }else {
            menView = menuListView(frame: CGRectMake(0,0,screenWidth,280))
        }
        return menView
    }
    
    //MARK: table view delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return source.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        if source.count > 0 {
            
            cell?.textLabel?.text = source[indexPath.row]
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.delegate == nil {
            self.contentTextField.text = source[indexPath.row]
        }else{
            
            if self.delegate.respondsToSelector("menuListViewBackIndexValue:") {
                self.delegate.menuListViewBackIndexValue?(indexPath.row)
            }
            if self.delegate.respondsToSelector("menuListViewBackStringValue:"){
                self.delegate.menuListViewBackStringValue?(source[indexPath.row])
            }
            self.contentTextField.text = source[indexPath.row]
        }
        
        self.contentTextField.resignFirstResponder()
    }
    
    
}
