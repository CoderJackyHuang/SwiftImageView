//
//  HYBLoadingImageView.swift
//
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

typealias HYBImageLoadingCompletion = (image: UIImage?) -> ();
typealias HYBImageCompletion = (image: UIImage?, isFromCache: Bool) -> ();

///
/// 图片加载控件，所有需要到网络加载的图片，都需要使用此控件操作
///
/// 作者：黄仪标 
///
/// Email: 632840804@qq.com
///
/// github：https://github.com/632840804
///
/// CSDN Blog: http://blog.csdn.net/woaifen3344/
///
/// Note：有任何可以，可以通过Email反馈，会在空闲时间处理，谢谢！
///
class HYBLoadingImageView: UIImageView {
  override convenience init() {
    self.init(frame: CGRectZero);
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    self.clipsToBounds = true;
    self.layer.masksToBounds = true;
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
    
    self.clipsToBounds = true;
    self.layer.masksToBounds = true;
  }
  
  ///
  /// 是否将图片控件显示为圆形
  ///
  /// isCircle true表示显示为圆
  ///
  func isCircle(isCircle: Bool = false) {
    if isCircle == true {
      var width = min(self.frame.size.width, self.frame.size.height);
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, width);
      self.layer.cornerRadius = width / 2;
    }
  }
  
  ///
  /// 加载图片
  ///
  /// url 图片请求地址
  ///
  func loadImage(url: String) {
    self.loadImage(url, holder: "");
  }
  
  ///
  /// 加载图片
  ///
  /// url 图片请求地址
  ///
  /// holder 占位图片名称
  ///
  func loadImage(url: String, holder: String) {
    self.loadImage(url, holder: holder, completion: nil);
  }
  
  ///
  /// 加载图片
  ///
  /// url 图片请求地址
  ///
  /// completion 图片加载完成时的回调闭包
  ///
  func loadImage(url: String, completion: HYBImageLoadingCompletion?) {
    self.loadImage(url, holder: "", completion: completion);
  }
  
  ///
  /// 加载图片
  ///
  /// url 图片请求地址
  ///
  /// holder 占位图片名称
  ///
  /// completion 图片加载完成时的回调闭包
  ///
  func loadImage(url: String, holder: String, completion: HYBImageLoadingCompletion?) {
    if !holder.isEmpty {
      self.image = UIImage(named: holder);
    }
    
    if url.isEmpty {
      completion?(image: nil);
      return;
    }
    
    HYBImageLoader.sharedInstance.loadImage(url, completionHandler: { (image, isFromCache) -> () in
      if image == nil { // 图片加载失败
        completion?(image: nil);
      } else {
        // 在图片加载成功后，如果处理添加图片显示的动画处理，如果在此处添加
        if !isFromCache {
          // 添加淡入淡出的动画效果
          let animation = CATransition();
          animation.duration = 0.65;
          animation.type = kCATransitionFade;
          animation.removedOnCompletion = true;
          self.layer.addAnimation(animation, forKey: "transition");
        }
        
        self.image = image;
        completion?(image: image);
      }
    });
  }
}

