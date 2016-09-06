//
//  NXHHomeViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHHomeViewController.h"
#import "NXHCollectionReusableView.h"
#import "MJDIYHeader.h"



@interface NXHHomeViewController ()
/**GIF*/
@property (nonatomic,strong) NSMutableArray * imageArr;


@end

@implementation NXHHomeViewController
#pragma mark - 刷新数据
- (void)setHeaderRefresh{
    // The drop-down refresh
    
    __weak  __typeof(self) weakSelf = self;
    self.collectionView.mj_header =  [MJDIYHeader headerWithRefreshingBlock:  ^{
        //Call this Block When enter the refresh status automatically
        [self loadNewData];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.mj_header endRefreshing];
        });

    }];

}
- (void)loadNewData{
    MYLog(@"刷新数据也");
}
static NSString * const reuseIdentifier = @"Cell";



    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderRefresh];
 
        self.collectionView.showsVerticalScrollIndicator = NO;
   // self.navigationItem.title = @"首页";
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // Do any additional setup after loading the view.
    //1.初始化layout
  //  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
   // layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
  //  layout.itemSize =CGSizeMake(110, 150);
    
    //2.初始化collectionView
 
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [self.collectionView registerClass:[NXHCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
   }


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    // Configure the cell
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1  ];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
 

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.width-30)/2, (self.view.width-30)/4);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake(self.view.width-20,( self.view.width-20)/2.4);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NXHCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
      
//    UIImageView * iamgeView = [[UIImageView alloc]initWithFrame:headerView.bounds];
//    iamgeView.highlightedImage = [UIImage imageNamed:@"home_top_bg"];
//    iamgeView.backgroundColor = [UIColor blackColor];
//   // iamgeView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [headerView.layer addSublayer: iamgeView.layer];
////
////    headerView.backgroundColor =[UIColor redColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//    label.text = @"这是collectionView的头部";
//    label.font = [UIFont systemFontOfSize:20];
//    [headerView addSubview:label];
//    
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MYLog(@"点击✅%ld",(long)indexPath.item);
}

- (NSMutableArray *)imageArr{
    if (!_imageArr)
    {
        for (int i =0; i <4; i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"太阳副本 %d",i]];
            [_imageArr addObject:image];
        }
        
    }
        return _imageArr;
        
     
}
#pragma mark - 旋转的抬太阳<UIScrollviewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    MYLog(@"验证");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
   // MYLog(@"scrollView.contentOffset.y)     %f",scrollView.contentOffset.y);
   // self.collectionView.mj_header
    
}


    
@end

