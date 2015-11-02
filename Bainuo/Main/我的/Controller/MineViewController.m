//
//  MineViewController.m
//  
//
//  Created by mac on 15/10/27.
//
//

#import "MineViewController.h"
#import "common.h"
#import "RegisterViewController.h"
#import "PhoneRegisterViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createButton];
    
    [self _createTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

#pragma mark - 创建头视图
- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 136)];
//    headerView.backgroundColor = [UIColor purpleColor];
    _tableView.tableHeaderView = headerView;
    
    //登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-60, 20, 120, 30)];
    loginButton.layer.cornerRadius = 3;
    [loginButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:70/255.0 blue:131/255.0 alpha:1]];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:loginButton];
    
    
    //注册按钮
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, 60, 60, 20)];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    title.text = @"立即注册";
    title.textColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:131/255.0 alpha:1];
    title.font = [UIFont systemFontOfSize:12];
    [registerButton addSubview:title];
    [headerView addSubview:registerButton];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 15, 60, 20, 20)];
    imageView.image = [UIImage imageNamed:@"icon_web_goforward_hig"];
    [headerView addSubview:imageView];
    
    //菜单视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 46)];
//    view.backgroundColor = [UIColor orangeColor];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [headerView addSubview:view];
    
    //循环创建菜单按钮
    NSArray *buttonNames = @[@"糯米券",@"代付款",@"卡包",@"收藏"];
    NSArray *buttonImages = @[@"mine_nuomiquan@3x",@"mine_daifukuan@3x",@"mine_card@3x",@"mine_shoucang@3x"];
    CGFloat buttonWidth = kScreenWidth / (buttonImages.count*1.0);
    
    for (int i = 0; i < buttonImages.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 90, buttonWidth, 60)];
        
        [button setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //设置标题label的偏移量
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(10, -30, 0, 0)];
        //设置图片偏移量
        [button setImageEdgeInsets:UIEdgeInsetsMake(-35,20, 0,0)];
        [button addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
    }
}

- (void)loginButtonAction
{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}
- (void)registerAction
{
    [self.navigationController pushViewController:[[PhoneRegisterViewController alloc] init] animated:YES];
}

- (void)_createButton
{
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 33, 33 );
    [rightBtn setImage:[UIImage imageNamed:@"mine_notification@3x.png"] forState:UIControlStateNormal];
//    [rightBtn addTarget: self
//                action:@selector(rightBtnAction)
//      forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn2.frame = CGRectMake(33, 0, 33, 33 );
    [rightBtn2 setImage:[UIImage imageNamed:@"icon_nav_cart_normal.png"] forState:UIControlStateNormal];
//    [rightBtn2 addTarget: self
//                 action:@selector(rightAction)
//       forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    //导航项中的左侧选项进行赋值
    self.navigationItem.rightBarButtonItems = @[right,right2];
}


#pragma mark - 协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0||section == 1||section == 3) {
        return 1;
    }
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
    }
    //    //辅助图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    
    //图片视图
    
    if (indexPath.section == 0)
    {
        //标题label
        cell.textLabel.text = [NSString stringWithFormat:@"订单"];
        cell.imageView.image = [UIImage imageNamed:@"mine_order@3x"];
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"VIP会员"];
        cell.imageView.image = [UIImage imageNamed:@"mine_vip@3x"];
    }
    else if (indexPath.section == 2&&indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"积分"];
        cell.imageView.image = [UIImage imageNamed:@"mine_credits@3x"];
    }
    else if (indexPath.section == 2&&indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"余额"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(充值卡充值)"];
        cell.imageView.image = [UIImage imageNamed:@"mine_money@3x"];
        
    }
    else if (indexPath.section == 2&&indexPath.row == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"促销券"];
        cell.imageView.image = [UIImage imageNamed:@"mine_promotion@3x"];
    }
    else if (indexPath.section == 2&&indexPath.row == 3)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"抵用券"];
        cell.imageView.image = [UIImage imageNamed:@"mine_voucher@3x"];
    }
    else if (indexPath.section == 3)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"设置"];
        cell.imageView.image = [UIImage imageNamed:@"mine_setting@3x"];
    }

    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {

        [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
    }
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
