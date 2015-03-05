//
//  HYBImageLoader.swift
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 图片下载类，使用NSCache作为缓存处理
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
class HYBImageLoader {
  /// 缓存处理对象
  var cache = NSCache()
  
  ///
  /// 声明为单例
  ///
  class var sharedInstance : HYBImageLoader {
    struct Loader {
      static let instance = HYBImageLoader()
    }
    return Loader.instance
  }
  
  ///
  /// 加载图片
  ///
  /// url 图片请求地址
  ///
  /// completion 加载完成时的回调，不论是加载成功还是加载失败，都会回调
  ///            image 可空类型，为nil表示加载失败，不为nil，表示加载成功
  ///            isFromCache Bool类型，表示是否是从缓存中提取出来的图片
  func loadImage(url: String, completionHandler:(image: UIImage?, isFromCache: Bool) -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
      var data: NSData? = self.cache.objectForKey(url.md5ForLoader) as? NSData
      
      if let goodData = data {
        let image = UIImage(data: goodData)
        dispatch_async(dispatch_get_main_queue(), {() in
          completionHandler(image: image, isFromCache: true)
        })
        return
      }
      
      var downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
        if (error != nil) {
          completionHandler(image: nil, isFromCache: false);
          return
        }
        
        if data != nil {
          let image = UIImage(data: data)
          self.cache.setObject(data, forKey: url.md5ForLoader)
          dispatch_async(dispatch_get_main_queue(), {() in
            completionHandler(image: image, isFromCache: false)
          })
          return
        }
        
      });
      downloadTask.resume()
    })
  }
}

///
/// String结构通用功能扩展
///
extension String {
  ///
  /// 获取自身md5加密后的字符串
  ///
  var md5ForLoader : String {
    let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
    let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
    
    CC_MD5(str!, strLen, result);
    
    var hash = NSMutableString();
    for i in 0 ..< digestLen {
      hash.appendFormat("%02x", result[i]);
    }
    result.destroy();
    
    return String(format: hash)
  }
}