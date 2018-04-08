//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by qwer on 2018/4/8.
//  Copyright © 2018年 qwer. All rights reserved.
//

/**
 Core Animation，中文翻译为核心动画，它是一组非常强大的动画处理API，使用它能做出非常炫丽的动画效果，而且往往是事半功倍。也就是说，使用少量的代码就可以实现非常强大的功能。
 Core Animation可以用在Mac OS X和iOS平台。
 Core Animation的动画执行过程都是在后台操作的，不会阻塞主线程。
 要注意的是，Core Animation是直接作用在CALayer上的，并非UIView。
 
 */

/**
 当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示。
 
 换句话说，UIView本身不具备显示的功能，是它内部的层才有显示功能。
 因此，通过调节CALayer对象，可以很方便的调整UIView的一些外观属性。
 
 每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根层）
 所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画；
 
 */

/**
 既然CALayer和UIView都能实现相同的显示效果，那究竟该选择谁好呢？
 其实，对比CALayer，UIView多了一个事件处理的功能。也就是说，CALayer不能处理用户的触摸事件，而UIView可以
 所以，如果显示出来的东西需要跟用户进行交互的话，用UIView；如果不需要跟用户进行交互，用UIView或者CALayer都可以。当然，CALayer的性能会高一些，因为它少了事件处理的功能，更加轻量级。
 
 */

/**
 
 CALayer可以实现哪些UIView不能实现的功能：
    1.阴影，圆角，带颜色的边框；
    2.3D变换
    3.非矩形范围
    4.透明遮罩
    5.多级非线性动画
 
 */

/***/

import UIKit

class DDLabel:UILabel{
    
    //这个方法会在DDLabel添加在父视图上时调用：
    override func draw(_ rect: CGRect){
        super.draw(rect)
        print("有一个视图添加到了屏幕上...")
    }
    
}

class ViewController: UIViewController {
    
    private lazy var xxLabel:DDLabel = {
       
        let xx = DDLabel()
        xx.frame = CGRect.init(x: 20, y: 40, width: 200, height: 160)
        xx.backgroundColor = UIColor.red
        xx.textColor = UIColor.white
        
        return xx
        
    }()

    /**
     CALayer的基本属性: bounds,position(位置,默认指中点),anchorPoint(锚点),backgroundColor(背景颜色),transform(形变属性)
     */
    
    /**
     UIView和CALayer的区别：
        UIView可以处理交互事件，CALayer不能处理交互事件；
       A.设置layer属性：
        1.设置layer的bounds，UIView的bounds跟着改变；
        2.设置layer的position，UIView的center跟着改变；
        3.设置layer的backgrondColor，UIView的backgroundColor不改变；
        4.设置layer的transform，UIView的transform跟着改变；
        5.设置layer的anchorPoint，UIView的center不改变；
      B.设置UIView属性：
        1.修改UIView的bounds，layer的bounds跟着改变；
        2.修改UIView的center，layer的position跟着改变;
        3.修改UIView的backgroundColor，layer的backgroundColor不改变;
        4.修改UIView的transform，layer的transform跟着改变;
        5.修改UIView的center，layer的anchorPoint不改变;
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.xxLabel)

//MARK:设置CALayer的属性：
        //1.修改layer的bounds，UIView的bounds是否改变：
        self.xxLabel.layer.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        print(self.xxLabel.bounds)

        //2.修改layer的positon，UIView的center是否改变：
        self.xxLabel.layer.position = CGPoint.init(x: 100, y: 100)
        print(self.xxLabel.center)

        //3.修改layer的backgroundColor，UIView的backgroundColor是否改变：
        self.xxLabel.layer.backgroundColor = UIColor.blue.cgColor
        print(self.xxLabel.backgroundColor ?? UIColor.white)

        //4.修改layer的transform(绕z轴旋转45度)，UIView的transform是否会改变：
        self.xxLabel.layer.transform = CATransform3DMakeRotation(CGFloat.pi/4, 0, 0, 1)
        print(self.xxLabel.transform)

        //5.修改layer的anchorPoint(定位点),UIView的center是否改变（anchorPoint针对position使用的）
        self.xxLabel.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        print(self.xxLabel.center)
        
//MARK:设置UIView的属性：
        //a.修改UIView的bounds，layer的bounds是否改变：
        self.xxLabel.bounds = CGRect.init(x: 0, y: 0, width: 120, height: 120)
        print(self.xxLabel.layer.bounds)
        
        //b.修改UIView的center，layer的position是否会改变：
        self.xxLabel.center = CGPoint.init(x: 130, y: 130)
        print(self.xxLabel.layer.position)
        
        //c.修改UIView的backgroundColor，layer的backgroundColor是否会改变：
        self.xxLabel.backgroundColor = UIColor.blue
        print(self.xxLabel.layer.backgroundColor ?? UIColor.white)
        
        //d.修改UIView的transform，layer的transform是否会改变：
        self.xxLabel.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        print(self.xxLabel.layer.transform)
        
        //e.修改UIView的center，layer的anchorPoint是否会改变：
        self.xxLabel.center = self.view.center
        print(self.xxLabel.layer.anchorPoint)
        
//MARK:UIView显示一张图片；
        let image = UIImage.init(named: "QQ.png")
        self.xxLabel.layer.contents = image?.cgImage
        self.xxLabel.layer.contentsGravity = kCAGravityResizeAspectFill   //设置UIView的contentMode属性，实际上操作的是CALayer的contentsGravity；
        self.xxLabel.layer.contentsScale = UIScreen.main.scale  //图片的像素尺寸和视图大小的比例；
        self.xxLabel.clipsToBounds = true //设置UIView的clipsToBounds，相当于设置CALayer的maskToBounds
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

