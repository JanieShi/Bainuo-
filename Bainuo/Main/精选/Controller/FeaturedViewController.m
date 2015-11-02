//
//  FeaturedViewController.m
//  
//
//  Created by mac on 15/10/27.
//
//

#import "FeaturedViewController.h"
#import "common.h"
#import "FeaturedCell.h"
#import "AFNetworking.h"
#import "DataService.h"
#import "DetailViewController.h"
#import "FeatureModel.h"
#import "FeaturedTableView.h"
@interface FeaturedViewController ()

{
    FeaturedTableView *_tableView;
    UILabel *hourLabel;
    UILabel *minuteLabel;
    UILabel *secondeLabel;
    NSString *_description;
    UIWebView *webView;
    NSMutableArray *_array;
    NSArray *_allArray;
}
@end

@implementation FeaturedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self _createTableView];
    
    
    for (int i = 0; i < 3; i++) {
        
    
    NSString *urlstr = [NSString stringWithFormat:@"/shopdeals?shop_id=%d",1745896+ i*4] ;
    
    [DataService requestUrl:urlstr params:nil httpMethod:@"GET" block:^(id result) {
//                    NSLog(@"%@",result);

        _allArray = result[@"deals"];
        if (_allArray != nil) {
            
            NSLog(@"%@",_allArray[0]);
            NSDictionary *dic = _allArray[0];

            FeatureModel *model = [[FeatureModel alloc] init];
            model.featureDescription = dic[@"description"];
            model.title = dic[@"title"];
            model.imageName = dic[@"image"];
            model.score = [dic[@"score"] stringValue];
//            NSLog(@"%@",model.score);
            NSNumber *current = dic[@"current_price"];
            float currentPrice = [current intValue]/100.0;
            model.current_price = [NSString stringWithFormat:@"%.1f",currentPrice];
            
            NSNumber *market = dic[@"market_price"];
            float marketPrice = [market intValue]/100.0;
            model.market_price = [NSString stringWithFormat:@"%.1f",marketPrice];
            
            NSNumber *sale = dic[@"sale_num"];
            int saleNum = [sale intValue];
            model.sale_num = [NSString stringWithFormat:@"%d",saleNum];
            model.deal_murl = dic[@"deal_murl"];

            [_array addObject:model];

             _tableView.dataDicArray = _array;
        }
        else if(_allArray.count == 0)
        {
        
            return ;
        }

       
    }];

    }
    [self _createButton];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}


- (void)_createButton
{
    //2.第二种方式:使用UIButton自定义
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 33, 33 );
    [rightBtn setImage:[UIImage imageNamed:@"icon_nav_saoyisao_normal@3x.png"] forState:UIControlStateNormal];
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




- (void)timerAction:(NSTimer *)timer
{
    int hour = [hourLabel.text intValue];
    int minute = [minuteLabel.text intValue];
    int second = [secondeLabel.text intValue];
    second--;
    secondeLabel.text = [NSString stringWithFormat:@"%.2d",second];
    if (second==0) {
        minute--;
        secondeLabel.text = @"59";
        minuteLabel.text = [NSString stringWithFormat:@"%.2d",minute];
        return;
    }
    if (minute == 0) {
        hour--;
        minuteLabel.text = @"59";
        hourLabel.text = [NSString stringWithFormat:@"%.2d",hour];
        return;
    }
    if (hour == 0) {
        secondeLabel.text = @"00";
        minuteLabel.text = @"00";
        [timer invalidate];
        return;
    }
}

- (void)_createTableView
{
    _tableView = [[FeaturedTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];

    
    [self.view addSubview:_tableView];
//    UINib *nib = [UINib nibWithNibName:@"FeaturedCell" bundle:nil];
//    [_tableView registerNib:nib forCellReuseIdentifier:@"FeaturedCell"];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight/2-100)];
    _tableView.tableHeaderView = headerView;
    
    
    UIButton *recommendButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth - 10, 70)];
    recommendButton.layer.cornerRadius = 5;
    recommendButton.backgroundColor = [UIColor colorWithRed:222/255.0 green:187/255.0 blue:24/255.0 alpha:0.5];
    [headerView addSubview:recommendButton];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    label1.text = @"每日推荐";
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = [UIColor whiteColor];
    [recommendButton addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, recommendButton.bounds.size.width-20, 20)];
    label2.text = @"膨膨冰  四川香天下火锅  韩膳宫  阳光码头海鲜";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor whiteColor];
    [recommendButton addSubview:label2];
    
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, headerView.bounds.size.height - 90)];
    secondView.layer.borderWidth = 0.5;
    secondView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [headerView addSubview:secondView];
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 25)];
    label11.text = @"精选抢购";
    label11.font = [UIFont systemFontOfSize:20];
    
    label11.textColor = [UIColor colorWithRed:222/255.0 green:187/255.0 blue:24/255.0 alpha:0.5];
    [secondView addSubview:label11];
    
    UILabel *startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 40, 15)];
    startTimeLabel.text = @"距开始";
    [secondView addSubview:startTimeLabel];
    startTimeLabel.font = [UIFont systemFontOfSize:12];
    startTimeLabel.textColor = [UIColor grayColor];
    
    
    hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 35, 20, 15)];
    hourLabel.backgroundColor = [UIColor grayColor];
    hourLabel.textColor = [UIColor whiteColor];
    hourLabel.text = @"11";
    hourLabel.textAlignment = NSTextAlignmentCenter;
    hourLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:hourLabel];
    UILabel *mao1 = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, 10, 15)];
    mao1.text = @":";
    [secondView addSubview:mao1];
    
    minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, 20, 15)];
    minuteLabel.backgroundColor = [UIColor grayColor];
    minuteLabel.textColor = [UIColor whiteColor];
    minuteLabel.text = @"59";
    minuteLabel.textAlignment = NSTextAlignmentCenter;
    minuteLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:minuteLabel];
    UILabel *mao2 = [[UILabel alloc] initWithFrame:CGRectMake(95, 35, 10, 15)];
    mao2.text = @":";
    [secondView addSubview:mao2];
    
    secondeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 35, 20, 15)];
    secondeLabel.backgroundColor = [UIColor grayColor];
    secondeLabel.textColor = [UIColor whiteColor];
    secondeLabel.textAlignment = NSTextAlignmentCenter;
    secondeLabel.text = @"59";
    secondeLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:secondeLabel];
    
    UILabel *beginTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 35, 45, 15)];
    beginTimeLabel.text = @"10:00场";
    beginTimeLabel.layer.borderWidth = 1;
    beginTimeLabel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    beginTimeLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:beginTimeLabel];
    
    UILabel *overTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 35, 45, 15)];
    overTimeLabel.text = @"17:00场";
    overTimeLabel.layer.borderWidth = 1;
    overTimeLabel.layer.borderColor = [[UIColor magentaColor]CGColor];
    overTimeLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:overTimeLabel];
    
    UIButton *vipButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 50, kScreenWidth, 42)];
    //    vipButton.backgroundColor = [UIColor purpleColor];
    //    [vipButton setImage:[UIImage imageNamed:@"home_t10_vip@3x"] forState:UIControlStateNormal];
    //    [vipButton setTitle:@" 抢购不限时&下单享立减" forState:UIControlStateNormal];
    
    [secondView addSubview:vipButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 80, 20)];
    imageView.image = [UIImage imageNamed:@"home_t10_vip@3x"];
    [vipButton addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 13, kScreenWidth - 90, 20)];
    titleLabel.text = @"抢购不限时&下单享立减";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [vipButton addSubview:titleLabel];
    
    UIImageView *arrows = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 20, 13, 10, 20)];
    arrows.image = [UIImage imageNamed:@"icon_arrows_gray_right@3x"];
    [vipButton addSubview:arrows];
    [vipButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    _array = [NSMutableArray array];
    
}

- (void)buttonAction
{
    
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
