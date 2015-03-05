# SwiftImageView
use to download image and fade out when finished

首先感谢前辈们所开源出来的作品，从他们身上学习到了不少知识，如今我也做一些开源的事，
这里写了一个Swift版本的图片控件，对于需要处理网络请求是需要方便的。

如果遇到任何问题，请选择下面的方式反馈予我，不胜感激！！！

作者：黄仪标

Email: 632840804@qq.com

github：https://github.com/632840804

CSDN Blog: http://blog.csdn.net/woaifen3344/

使用方法非常简单：
    let imageView = HYBLoadingImageView();
    imageView.frame = CGRectMake(100, 100, 80, 80);
    self.view.addSubview(imageView);
    
    imageView.isCircle(isCircle: true);
    imageView.loadImage("http://static.oschina.net/uploads/user/116/232345_50.jpg?t=1374372254000", holder: "") { (image) -> () in
      println("加载成功了");
    };
  如果不需要占位图片，也不需要加载完成后额外处理，只需要这样：
  imageView.loadImage("http://static.oschina.net/uploads/user/116/232");
  
  
  好了，希望对大家有所帮助，也希望大家在使用过程中，遇到问题时，能反馈回来！！！
  
