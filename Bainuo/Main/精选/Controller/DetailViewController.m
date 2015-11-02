//
//  DetailViewController.m
//  Bainuo
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "DetailViewController.h"
#import "common.h"
@interface DetailViewController ()
{
//    UIWebView *webView;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建网络视图
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    NSURL *url =[NSURL URLWithString:_urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    
    //页面自适应
    web.scalesPageToFit = YES;
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
