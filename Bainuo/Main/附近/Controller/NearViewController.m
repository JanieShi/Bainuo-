//
//  NearViewController.m
//  
//
//  Created by mac on 15/10/27.
//
//

#import "NearViewController.h"
#import "common.h"

@interface NearViewController ()

@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self _createNavButton];
    
//    [self _createHeaderView];
}





#pragma mark - 创建Navbutton
- (void)_createNavButton
{
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 33, 33 );
    [rightBtn setImage:[UIImage imageNamed:@"icon_nav_sousuo_normal@3x.png"] forState:UIControlStateNormal];
    [rightBtn addTarget: self
                 action:@selector(rightBtnAction)
       forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn2.frame = CGRectMake(33, 0, 33, 33 );
    [rightBtn2 setImage:[UIImage imageNamed:@"icon_nav_cart_normal.png"] forState:UIControlStateNormal];
    [rightBtn2 addTarget: self
                  action:@selector(rightAction)
        forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    //导航项中的左侧选项进行赋值
    self.navigationItem.rightBarButtonItems = @[right,right2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
