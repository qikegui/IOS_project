//
//  ShufflingView.swift
//  ShufflingSwift
//
//  Created by qkg on 15/11/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class ShufflingView: UIView ,UICollectionViewDataSource ,UICollectionViewDelegate {

    private var sourceImageArray : [UIImage] = []
    private var mainView : UICollectionView!
    private var flowLayout : UICollectionViewFlowLayout!
    private var contentLength : Int = 0
    private var flagArray: [String] = []
    var initLoop : Bool = true
    var locationImageArray : [String] {
        willSet{
            makeLocationImageArray(newValue)
            
        }
    }
    var urlImageArray : [String] {
        willSet{
          makeUrlImageArray(newValue)
        }
  
    }
    
    override init(frame: CGRect) {
        locationImageArray = []
        urlImageArray = []
        super.init(frame: frame)
        _initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:
    class func ShufflingWithUrlArray(frame:CGRect,urlImageArray:[String]) -> ShufflingView {
        let shufflingView = ShufflingView(frame: frame)
        shufflingView.urlImageArray = urlImageArray
        return shufflingView
    }
    // MARK:
    class func ShufflingWithLocationArray(frame:CGRect,locationArray:[String]) -> ShufflingView {
        let shufflingView = ShufflingView(frame: frame)
        shufflingView.locationImageArray = locationArray
        return shufflingView
    }
    // MARK:
    
    func _initView() {
        
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.itemSize = self.bounds.size
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        self.mainView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        mainView.backgroundColor = UIColor.clearColor()
        mainView.pagingEnabled = true
        mainView.showsHorizontalScrollIndicator = false
        mainView.showsVerticalScrollIndicator = false
        mainView.registerClass(ShufflingViewCell.self, forCellWithReuseIdentifier: "cell")
        mainView.dataSource = self
        mainView.delegate = self
        self.addSubview(mainView)
        
        self.initLoop = true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.contentLength
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? ShufflingViewCell
        
        let index = indexPath.item % sourceImageArray.count
        cell?.image.image = sourceImageArray[index]
        cell?.titleLabel.text = "helloWorld"
        cell?.pageControl.currentPage = index
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func makeLocationImageArray(newValue:[String]) {
        
        var images : [UIImage] = []
        for imageStr in newValue {
            
            let image = UIImage(named: imageStr)
            if let data = image {
                images.append(data)
            }
        }
        
        self.sourceImageArray = images
        self.contentLength = self.initLoop ? sourceImageArray.count * 100 : sourceImageArray.count
        self.mainView.reloadData()
    }
    
    func makeUrlImageArray(newValue:[String]) {
        var images : [UIImage] = []
        for _ in newValue {
            let image = UIImage()
            images.append(image)
        }
        
        sourceImageArray = images
        self.contentLength = self.initLoop ? sourceImageArray.count * 100 : sourceImageArray.count
        self.flagArray = newValue
        loadImageWithUrlArray(newValue)
    }
    
    func loadImageWithUrlArray(urlArray:[String]) {
        for var i = 0 ;i < urlArray.count; i++ {
            let url = NSURL(string: urlArray[i])
            if let data = url {
                loadImageWithUrl(data,index: i)
            }
        }
    }
    
    func loadImageWithUrl(url:NSURL,index:Int){
        
        let sesson = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: url)
        
        let task : NSURLSessionDataTask = sesson.dataTaskWithRequest(request) { (data:NSData?, responce:NSURLResponse?, error:NSError?) -> Void in
            if (error == nil) {
                let image = UIImage(data: data!)
                if image != nil {
                    
                   self.sourceImageArray[index] = image!
                    if index == 0{
                        self.mainView.reloadData()
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
