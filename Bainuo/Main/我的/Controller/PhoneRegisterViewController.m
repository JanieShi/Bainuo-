//
//  PhoneRegisterViewController.m
//  Bainuo
//
//  Created by Mac on 15/10/28.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "PhoneRegisterViewController.h"
#import "common.h"
@interface PhoneRegisterViewController ()

@end

@implementation PhoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"填写手机号";
    [self _createLeftButton];
    [self _createViews];
    
}

- (void)_createViews
{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70,kScreenWidth-10, 50)];
    descriptionLabel.text = @"注册成功后，可用其登陆百度所有产品，如贴吧、文库、知道、地图等";
    descriptionLabel.textColor = [UIColor lightGrayColor];
    descriptionLabel.numberOfLines = 0;
    [self.view addSubview:descriptionLabel];
    
    
    UITextField *phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(5, 130, kScreenWidth - 10, 50)];
    phoneNum.layer.borderWidth = 0.5;
    phoneNum.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 40)];
    leftView.text = @"  手机号";
    phoneNum.leftView = leftView;
    phoneNum.leftViewMode = UITextFieldViewModeAlways;
    phoneNum.placeholder = @" 填写手机号，其他用户不可见";
    [self.view addSubview:phoneNum];
    
    
    UITextField *passWord = [[UITextField alloc] initWithFrame:CGRectMake(5, 190, kScreenWidth - 10, 50)];
    passWord.layer.borderWidth = 0.5;
    passWord.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    UILabel *leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 40)];
    leftView2.text = @"  密码";
    passWord.leftView = leftView2;
    passWord.leftViewMode = UITextFieldViewModeAlways;
    passWord.placeholder = @" 6-14位，建议数字、字母、符号";
    [self.view addSubview:passWord];
    
    
    
    UIButton *getPassButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 250, kScreenWidth - 10, 50)];
    [getPassButton setBackgroundColor:[UIColor colorWithRed:232/255.0 green:174/255.0 blue:235/255.0 alpha:1]];
    [getPassButton setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    [getPassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getPassButton addTarget:self action:@selector(GetPassButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getPassButton];
    
    
    UILabel *warningLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 310, kScreenWidth - 10, 50)];
    warningLabel1.text = @"阅读并接受";
    [self.view addSubview:warningLabel1];
    UILabel *warningLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 310, kScreenWidth - 110, 50)];
    warningLabel2.text = @"<<百度用户协议>>";
    warningLabel2.textColor = [UIColor blueColor];
    [self.view addSubview:warningLabel2];
    
}
- (void)_createLeftButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 33, 33 );
    [leftBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal@3x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = left;
}

- (void)leftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
