//
//  ViewController.m
//  PhotoBroswer
//
//  Created by haohao on 17/1/18.
//  Copyright © 2017年 浩浩. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowser.h"
#import "UIButton+WebCache.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片浏览器";
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self cratePicBtn];
}



-(void)cratePicBtn{
    //缩略图
    NSArray* imgArr = @[@"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    //高清图
    NSArray* imgArr2 = @[@"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    
    
    //本地图
    NSArray* imgNameArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"photo.jpg"];
    
    int col = 3;//列
    int row = imgArr.count/col; //行
    if (imgArr.count%col>0) {
        row +=1;
    }
    int btnW = 90;//按钮长
    int btnH = 90;//按钮宽
    
    //按钮间距
    int left = (SCREEN_WIDTH - col*btnW)/(col+1);
    int padH = (400-row*btnH)/(row+1);
    for (int i = 0; i<imgArr.count; i++) {
        /** 需要的按钮 */
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(i%col*btnW+(i%col+1)*left, i/col*btnH+(i/col+1)*padH, btnW, btnH);
        [btn setFrame:frame];
        btn.layer.cornerRadius = 4;
        
        
        //[btn setBackgroundImage:[UIImage imageNamed:imgNameArr[i]] forState:UIControlStateNormal];
        
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgArr[i]] forState:UIControlStateNormal];
        
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}

-(void)btnClick:(UIButton*)btn{
    
    //缩略图
    NSArray* imgArr = @[@"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    //高清图
    NSArray* imgArr2 = @[@"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                         @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                         @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                         @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                         @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                         @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    
    
    //本地图
    NSArray* imgNameArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"photo.jpg"];
    
    
    int tag = btn.tag;
    
    if(tag>=imgArr2.count){
        //下标超出数组个数,会崩溃
        return;
    }
    
    PhotoBrowser* browserVc = [[PhotoBrowser alloc]init];
    browserVc.currPicIndex = tag;
    browserVc.localFlag = false;
    browserVc.imgArr = imgArr2;
    [browserVc showPic];
   
}



@end
