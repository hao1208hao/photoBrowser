//
//  PhotoBrowser.m
//  PhotoBroswer
//
//  Created by haohao on 17/1/18.
//  Copyright © 2017年 浩浩. All rights reserved.
//

#import "PhotoBrowser.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PhotoBrowser ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *indexLabel;

@end

@implementation PhotoBrowser

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createScrollView];
}

-(void)createScrollView{
    //创建scrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    //self.scrollView.minimumZoomScale = 1.0;
    //self.scrollView.maximumZoomScale = 2.0;
    
    [self.scrollView setContentSize:CGSizeMake(self.imgArr.count*SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollView];
    
    //显示图片
    for (int i=0; i<self.imgArr.count; i++) {
        
        UIImageView* imgView = [[UIImageView alloc]init];
        if (self.localFlag) {
            //加载的是本地图片
            [imgView setImage:[UIImage imageNamed:self.imgArr[i]]];
        }else{
            //加载的是网络图片
            [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@""]];
        }
        [imgView setFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imgView setTag:i];
        [imgView setUserInteractionEnabled:YES];
        [self.scrollView addSubview:imgView];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closePic:)];
        [tap setNumberOfTapsRequired:1];
        [imgView addGestureRecognizer:tap];
    }
    
    //下标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    indexLabel.frame = CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-40, 100, 40);
    indexLabel.layer.cornerRadius = 15;
    indexLabel.clipsToBounds = YES;
    indexLabel.text = [NSString stringWithFormat:@"%d/%lu", self.currPicIndex+1,(unsigned long)self.imgArr.count];
    [self.view addSubview:indexLabel];
    self.indexLabel = indexLabel;
    
    [_scrollView setContentOffset:CGPointMake(self.currPicIndex*SCREEN_WIDTH, 0) animated:YES];
    
}

//打开图片浏览器
-(void)showPic{
     [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:self animated:NO completion:nil];
}

//关闭图片浏览器
-(void)closePic:(UITapGestureRecognizer*)tap{
    UIImageView* imgView = (UIImageView*)tap.view;
    int tag = imgView.tag;    
    //如果需要获取最后一个点击图片的tag,实现代理就行
    [self.delegate getLastClickImg:tag];
    [_scrollView removeFromSuperview];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark UIScrollViewDelegate
#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    self.indexLabel.text = [NSString stringWithFormat:@"%d/%d", index + 1, self.imgArr.count];
}

//缩放过程中的图像
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id obj in scrollView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            return obj;
        }
    }
    return nil;
}

//缩放结束
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"缩放的比例:%f",scale);
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
   //NSLog(@"");
}


@end
