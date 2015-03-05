//
//  HYBRootController.swift
//  LoadImageDemo
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

class HYBRootController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad();
    
    let imageView = HYBLoadingImageView();
    imageView.frame = CGRectMake(100, 100, 80, 80);
    self.view.addSubview(imageView);
    
    imageView.isCircle(isCircle: true);
    imageView.loadImage("http://static.oschina.net/uploads/user/116/232345_50.jpg?t=1374372254000", holder: "") { (image) -> () in
      println("加载成功了");
    };
    
   // imageView.loadImage("http://static.oschina.net/uploads/user/116/232345_50.jpg?t=1374372254000");
  }
}
