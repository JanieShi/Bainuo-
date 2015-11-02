//
//  MainTabBarController.m
//  
//
//  Created by mac on 15/10/27.
//
//

#import "MainTabBarController.h"

@interface MainTabBarController (){
    
    UIImageView *_selectedView;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createSubControllers];
    
    [self _createTabBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTabBar{
    
    //01 移除tabBarButton
    //UITabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //02 tabBar背景图片: 创建imageView 作为 子视图 添加到 tabBar上
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 49)];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:bgImageView];
    
    
    //04 tabbar 标签button
    CGFloat itemWidth = kScreenWidth/5;
    NSArray *imageNames =@[@"icon_tab_shouye_normal@3x.png",
           @"icon_tab_fujin_normal@3x.png",
           @"tabbar_voice_icon@3x.png",
           @"tab_icon_selection_normal@3x.png",
           @"icon_tab_wode_normal@3x.png",
           ];
    NSArray *selectedImages = @[@"icon_tab_shouye_highlight@3x.png",
          @"icon_tab_fujin_highlight@3x.png",
          @"tabbar_voice_icon@3x.png",
          @"tab_icon_selection_highlight@3x.png",
          @"icon_tab_wode_highlight@3x.png",
          ];
    
    NSArray *names = @[@"首页",@"附近",@"语音",@"精选",@"我的"];
    
       for (int i = 0; i<imageNames.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 49)];
        
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        
        button.userInteractionEnabled = YES;
           
        [button setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
           
        if(i!=2)
        {
//            [button setTitle:names[i] forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.bounds.size.width / 2-10, 30, button.bounds.size.width, 20)];
            label.text = names[i];
            label.font = [UIFont systemFontOfSize:10];
            [button addSubview:label];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 10, 10)];
//            [button setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, -10, 0)];
        }

        
        
        button.tag = i;
        
        [button addTarget:self action:@selector(_selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
           
       if (i == 0) {
           _tmpBtn = button;
           _tmpBtn.selected = YES;
       }
           
    }
    

}

- (void)_selectAction:(UIButton *)button{
    
    self.selectedIndex = button.tag;
    
    if (_tmpBtn == nil){
        button.selected = YES;
        _tmpBtn = button;
    }
    else if (_tmpBtn !=nil && _tmpBtn == button){
        button.selected = YES;
        
    }
    else if (_tmpBtn!= button && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        button.selected = YES;
        _tmpBtn = button;
    }
    
}

- (void)_createSubControllers{

    NSArray *names = @[@"Home",@"Near",@"Record",@"Featured",@"Mine"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:names.count];
    
    for ( int i  = 0; i < 5; i++) {
//        NSString *name = names[i];
        //创建storyBoard对象
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        
        //通过 storyBoard创建控制器对象
        BaseNavController *navVc = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:navVc];
        
    }
    self.viewControllers = navArray;
    
    
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
