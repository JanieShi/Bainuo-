//
//  RegisterViewController.m
//  Bainuo
//
//  Created by Mac on 15/10/27.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "RegisterViewController.h"
#import "common.h"
#import "PhoneRegisterViewController.h"

@interface RegisterViewController ()
{
    UIView *_tabBarView1;
    UIView *_tabBarView2;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"短信验证登录";
    
    [self _createButton];
    
    [self _createTextFiled];
    
    [self _createTabBarView];
}

- (void)_createTextFiled
{
    UITextField *phoneTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 40)];
    UIImageView *phone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 33)];
    phone.image = [UIImage imageNamed:@"icon_phone@3x"];
    phoneTextFiled.layer.borderWidth = 0.5;
    phoneTextFiled.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    phoneTextFiled.leftView = phone;
    phoneTextFiled.leftViewMode = UITextFieldViewModeAlways;
    phoneTextFiled.placeholder = @"   请输入手机号";
    [self.view addSubview:phoneTextFiled];
    
    
    
    UITextField *keyTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, 40)];
    UIImageView *key = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 33)];
    key.image = [UIImage imageNamed:@"icon_pin@3x"];
    keyTextFiled.layer.borderWidth = 0.5;
    keyTextFiled.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    keyTextFiled.leftView = key;
    keyTextFiled.leftViewMode = UITextFieldViewModeAlways;
    keyTextFiled.placeholder = @"   请输入短信中的验证码";
    [self.view addSubview:keyTextFiled];
    
    
    UIButton *getPass = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, 40)];

    UILabel *label = [[UILabel alloc] initWithFrame:getPass.bounds];
    label.text = @"获取验证码";
    label.textColor = [UIColor lightGrayColor];
    [getPass addSubview:label];
    [phoneTextFiled addSubview:getPass];
    
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 170, kScreenWidth - 40, 50)];
    loginButton.backgroundColor = [UIColor lightGrayColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [loginButton addTarget:self action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
    [self.view addSubview:loginButton];
    
    UIButton *userPassButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 240, 100, 30)];

    UILabel *label1 = [[UILabel alloc] initWithFrame:userPassButton.bounds];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"账号密码登录";
    //    [loginButton addTarget:self action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
    [userPassButton addSubview:label1];
    [self.view addSubview:userPassButton];
    
}

- (void)_createTabBarView
{
    _tabBarView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    [self.view addSubview:_tabBarView1];
    
    NSArray *buttonImageArray = @[@"icon_sms_weixin@3x",@"icon_sms_qq@3x",@"icon_arrows_gray_down@3x"];
    NSArray *buttonTitlerray = @[@"微信登陆",@"QQ登录",@"其他登录"];

    CGFloat buttonWidth = kScreenWidth / 3.0;
    for (int i = 0; i<buttonImageArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 50)];
        button.tag = i;
        [button setImage:[UIImage imageNamed:buttonImageArray[i]] forState:UIControlStateNormal];
        [button setTitle:buttonTitlerray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView1 addSubview:button];
    }
}


- (void)buttonAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 2 && btn.selected) {
        _tabBarView1.frame = CGRectMake(0, kScreenHeight-100, kScreenWidth, 50);
        [btn setImage:[UIImage imageNamed:@"icon_arrows_gray_up@3x"] forState:UIControlStateNormal];
        _tabBarView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
        [self.view addSubview:_tabBarView2];
        NSArray *buttonImageArray = @[@"icon_sms_sina@3x",@"icon_sms_qq_wb@3x",@"icon_sms_renren@3x"];
        NSArray *buttonTitlerray = @[@"新浪微博",@"腾讯微博",@"人人网"];
        
        CGFloat buttonWidth = kScreenWidth / 3.0;
        for (int i = 0; i<buttonImageArray.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 50)];
            button.tag = i;
            [button setImage:[UIImage imageNamed:buttonImageArray[i]] forState:UIControlStateNormal];
            [button setTitle:buttonTitlerray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
//            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView2 addSubview:button];
        }
    }
    if(btn.tag == 2 && !btn.selected)
    {
        _tabBarView2.hidden = YES;
        _tabBarView1.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
        [btn setImage:[UIImage imageNamed:@"icon_arrows_gray_down@3x"] forState:UIControlStateNormal];
    }
}


- (void)_createButton
{
    //2.第二种方式:使用UIButton自定义
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 33, 33 );
    [leftBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal@3x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn addTarget: self
    //                action:@selector(rightBtnAction)
    //      forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = left;
    
    
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn2.frame = CGRectMake(40, 0, 40, 40 );

    UILabel *lable = [[UILabel alloc] initWithFrame:rightBtn2.bounds];
    lable.font = [UIFont systemFontOfSize:17];
    lable.text = @"注册";
    lable.textColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:131/255.0 alpha:1];
    [rightBtn2 addSubview:lable];
    [rightBtn2 addTarget: self
                 action:@selector(rightButtonAction)
       forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    //导航项中的左侧选项进行赋值
    self.navigationItem.rightBarButtonItem = right2;
}

- (void)leftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightButtonAction
{
    [self.navigationController pushViewController:[[PhoneRegisterViewController alloc] init] animated:YES];
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
