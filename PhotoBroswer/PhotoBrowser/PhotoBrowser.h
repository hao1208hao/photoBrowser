//
//  PhotoBrowser.h
//  PhotoBroswer
//
//  Created by haohao on 17/1/18.
//  Copyright © 2017年 浩浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowser : UIViewController

//当前展示图片的下标,默认是0
@property(nonatomic,assign) int currPicIndex;

//图片标识
@property(nonatomic,assign) BOOL localFlag;  //是否是本地图片

//加载本地图片或者网络图片
@property(nonatomic,strong) NSArray* imgArr;


//展示图片
-(void)showPic;

@end
