//
//  SearchBar.m
//  
//
//  Created by mac on 15/10/31.
//
//

#import "SearchBar.h"

@implementation SearchBar

/** 使用代码创建控件的时候，调用init的时候会调用此方法 */
 - (instancetype)initWithFrame:(CGRect)frame {
     if (self = [super initWithFrame:frame]) {
        // 设置内容垂直居中
         [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
         
         self.backgroundColor = [UIColor whiteColor];
  
         // 添加图标“放大镜“
         UIImageView *searchBarIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
         searchBarIconView.image = [UIImage imageNamed:@"icon_search@3x"];
  

         // 设置”放大镜“在imageView中居中
         [searchBarIconView setContentMode:UIViewContentModeCenter];

         // 设置textField的左部控件（”放大镜“所属的imageView）显示
         [self setLeftViewMode:UITextFieldViewModeAlways];

         // 设置图标到搜索栏
         self.leftView = searchBarIconView;

         // 显示清除按钮
         [self setClearButtonMode:UITextFieldViewModeAlways];
         
         self.placeholder = @"搜索商家或地点";
     }
 
     return self;
}

@end
