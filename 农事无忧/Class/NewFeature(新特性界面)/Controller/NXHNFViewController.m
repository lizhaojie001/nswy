//
//  NXHNFViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHNFViewController.h"
#import "NXHpageControl.h"
#import "NXHMainViewController.h"

@interface NXHNFViewController ()<UIScrollViewDelegate>


/**滚动视图对象*/
@property (strong, nonatomic) UIScrollView *scrollView;
/**视图中小圆点，对应视图的页码*/
@property (strong, nonatomic) NXHpageControl *pageControl;
/**动态数组对象，存储图片*/

@property (strong, nonatomic) NSMutableArray *images;

@end
@implementation NXHNFViewController



- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
       //初始化scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    //初始化pageControl
    self.pageControl = [[NXHpageControl alloc]initWithFrame:CGRectMake(100, self.view.height-50, self.view.width-200, 30)];
  //  self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    //初始化数组，存储滚动视图的图片
    self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"guide_one.jpg"],[UIImage imageNamed:@"guide_two.jpg"],[UIImage imageNamed:@"guide_three.jpg"],[UIImage imageNamed:@"guide_four.jpg"], nil ];
    //把scrollView与pageControl添加到当前视图中
    [self.scrollView sizeToFit];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    //设置视图的背景颜色
    self.view.backgroundColor = [UIColor blackColor];
    //调用 setuoPage方法
    [self setupPage:nil];
}
//改变滚动视图的方法实现
- (void)setupPage:(id)sender
{
    //取消弹性
    self.scrollView.bounces = NO;
    //设置委托
    self.scrollView.delegate = self;
    //设置背景颜色
    self.scrollView.backgroundColor = [UIColor blackColor];
    //设置取消触摸
    self.scrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    self.scrollView.clipsToBounds = YES;
    //设置是否可以缩放
    self.scrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    self.scrollView.pagingEnabled = YES;
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.scrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //用来记录页数
    NSUInteger pages = 0;
    //用来记录scrollView的x坐标
    int originX = 0;
    for(UIImage *image in self.images)
    {
        //创建一个视图
        UIImageView *pImageView =  [[UIImageView alloc]initWithFrame:CGRectZero]  ;
        //设置视图的背景色
        pImageView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        //设置imageView的背景图
        [pImageView setImage:image];
        //给imageView设置区域
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 0;
        rect.size.width = self.scrollView. width;
        rect.size.height = self.scrollView.height;
        pImageView.frame = rect;
        //设置图片内容的显示模式(自适应模式)
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        //把视图添加到当前的滚动视图中
        [self.scrollView addSubview:pImageView];
        
        //下一张视图的x坐标:offset为:self.scrollView.frame.size.width.
        originX += self.scrollView .width;
        //记录scrollView内imageView的个数
        pages++;
    }
    //设置页码控制器的响应方法
   // [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    //设置总页数
    self.pageControl.numberOfPages = 4;
    self.pageControl.userInteractionEnabled =NO;
    //默认当前页为第一页
    self.pageControl.currentPage = 0;
    //为页码控制器设置标签
    self.pageControl.tag = 110;
    //设置滚动视图的位置
    [self.scrollView setContentSize:CGSizeMake(originX, self.scrollView.bounds.size.height)];
    [self plusButton];
}
/**
 *  添加按钮
 *
 *  @return
 */
- (UIButton *)plusButton
{
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed: @"guide_go_btn"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(gotoNX) forControlEvents:UIControlEventTouchUpInside];
    
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
    btn.frame =CGRectMake(self.scrollView.contentSize.width -self.scrollView.width+60, self.pageControl.y-20-(self.view.width-120)/3.8 , self.view.width-120,  (self.view.width-120)/3.8);
    [self.scrollView addSubview:btn];
        
    
    return btn;
}
-(void)gotoNX{
    // 点击立即体验按钮
   
      // 跳转到核心界面,push,modal,切换跟控制器的方法
        NXHKeyWindow.rootViewController = [[NXHLoginViewController alloc] init];
        
        CATransition *anim = [CATransition animation];
        anim.duration = 0.5;
    /**
     *   fade     //交叉淡化过渡(不支持过渡方向)
     
     push     //新视图把旧视图推出去
     
     moveIn   //新视图移到旧视图上面
     
     reveal   //将旧视图移开,显示下面的新视图
     
     cube     //立方体翻滚效果
     
     oglFlip  //上下左右翻转效果
     
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     
     rippleEffect //滴水效果(不支持过渡方向)
     
     pageCurl     //向上翻页效果
     
     pageUnCurl   //向下翻页效果
     
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     
     */
        anim.type = @"rippleEffect";
        [NXHKeyWindow.layer addAnimation:anim forKey:nil];
     

}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    MYLog(@"指示器的当前索引值为:%ld",(long)self.pageControl.currentPage);
    //获取当前视图的页码
    CGRect rect = self.scrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [self.scrollView scrollRectToVisible:rect animated:YES];
    
}
#pragma mark-----UIScrollViewDelegate---------
//实现协议UIScrollViewDelegate的方法，必须实现的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前视图的宽度
    CGFloat pageWith = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    [self.pageControl curPageControl:page];

    //切换改变页码，小圆点
    self.pageControl.currentPage = page;
       MYLog(@"self.pageControl.currentPage=%d",page);
}


@end