//
//  HomeViewController.m
//
//
//  Created by mac on 15/10/27.
//
//

#import "HomeViewController.h"

@interface HomeViewController (){
    
    UITableView *_tableView;
    
    UIScrollView *_scrollView;//加在头视图上的滑动视图
    
    UIPageControl *_pageCtrl;
    //--------第一组单元格内容-----------
    UIView *_ClassifyView;//加在第一个单元格上的分类界面
    
    UIButton *_button;//分类界面按钮
    
    UIView *_SecondView;//加在第二个单元格上的分类界面
    
    UIView *_newUser; //新用户专享界面，第三个单元格
    
    UIView *_row3View;//第四个单元格
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createNavButton];
    [self _createScrollView];
    [self _createClassifyView];
    [self _createSecondView];
    [self _createRow3View];
    
}

#pragma mark - 创建视图
-(void)_createScrollView{
    
    //创建表示图
    _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
#pragma mark - 创建头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.backgroundColor = [UIColor whiteColor];
    //给tableView的头视图属性赋值
    _tableView.tableHeaderView = view;
    
    
#pragma mark - 创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:view.bounds];
    //内容尺寸
    _scrollView.contentSize = CGSizeMake(kScreenWidth*5, 80);
    
    //设置代理
    _scrollView.delegate = self;
    
    //分页效果
    _scrollView.pagingEnabled = YES;
    
    //隐藏水平方向的滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //头视图添加滑动视图
    [view addSubview:_scrollView];
    
    for (int i = 0; i < 3; i++) {
        //循环创建视图添加到scrollView上
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth , 0, kScreenWidth, 80)];
        
        NSString *imageName = [NSString stringWithFormat:@"scrollView%d.png",i+1];
        
        imageView.image = [UIImage imageNamed:imageName];
        
        [_scrollView addSubview:imageView];
        
    }
    
#pragma mark - 创建PageControl
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 30, kScreenWidth, 30)];
    
    //常用的属性
    _pageCtrl.numberOfPages = 3;
    //    _pageCtrl.backgroundColor = [UIColor clearColor];
    
    _pageCtrl.currentPage = 0;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [_pageCtrl addTarget:self
                  action:@selector(pageCon:)
        forControlEvents:UIControlEventValueChanged];
    
    [view addSubview:_pageCtrl];
    
}

-(void)pageCon:(UIPageControl *)sender{
    //点击pageCoontrol时，scrollView切换到对应图片
    NSInteger index = sender.currentPage;
    
    //计算scrollView的偏移量
    CGFloat contentoffsetX = index * kScreenWidth;
    
    CGPoint off = CGPointMake(contentoffsetX, 0);
    
    //滚动视图控制偏移量
    [_scrollView setContentOffset:off animated:YES];
    
}


#pragma mark - 导航栏按钮和搜索栏
- (void)_createNavButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 60, 33 );
    [leftBtn setImage:[UIImage imageNamed:@"home_arrow_down_red@3x"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"杭州" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:100/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    //设置图片偏移量
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -60)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];
    
    
    //转换成UIBarButtonItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = left;
    
    //第二种方式:使用UIButton自定义
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 33, 33 );
    [rightBtn setImage:[UIImage imageNamed:@"icon_nav_saoyisao_normal@3x.png"] forState:UIControlStateNormal];
    //    [rightBtn addTarget: self
    //                 action:@selector(rightBtnAction)
    //       forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn2.frame = CGRectMake(33, 0, 33, 33 );
    [rightBtn2 setImage:[UIImage imageNamed:@"icon_nav_cart_normal.png"] forState:UIControlStateNormal];
    //    [rightBtn2 addTarget: self
    //                  action:@selector(rightAction)
    //        forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    //导航项中的右侧选项进行赋值
    self.navigationItem.rightBarButtonItems = @[right,right2];
    
    
    //添加搜索框
    SearchBar *searchBar = [[SearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, 160, 30);
    self.navigationItem.titleView = searchBar;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 7;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifer];
    //
    //    if (cell == nil && indexPath.section == 0) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifer];
    //    }
    
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];;
    
    if (cell==nil && indexPath.section == 0) {
        
        
        cell = [[FavoriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    else {
      
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FavoriteCell" owner:nil options:nil] lastObject];
        
    }
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        [cell.contentView addSubview:_ClassifyView];
    }else if (indexPath.row == 1 && indexPath.section == 0) {
        cell.backgroundView = _SecondView;
    }else if (indexPath.row == 2 && indexPath.section == 0){
        cell.backgroundView = _row3View;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            return 160;
        }
        if (indexPath.row == 2) {
            return 332;
        }
        if (indexPath.row == 3) {
            return 120;
        }
    }
    
    return 80;
    
}
//------------------第二组-----------




//------------------第一组------------
#pragma mark - row3
- (void)_createRow3View{
    
    _row3View = [[UIView alloc] init];
    _row3View.backgroundColor = [UIColor whiteColor];
    
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(3, 3, kScreenWidth, 80)];
    view6.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view6];
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label11.text = @"新用户专享";
    label11.font = [UIFont boldSystemFontOfSize:17];
    [view6 addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 200, 30)];
    label12.text = @"1毛钱吃大餐  最高立减30元";
    label12.font = [UIFont boldSystemFontOfSize:12];
    [view6 addSubview:label12];
    
    UIImageView *imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 68 , 8, 56, 56)];
    imageView6.image = [UIImage imageNamed:@"1块钱.png"];
    [view6 addSubview:imageView6];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(3, 86, kScreenWidth/2 - 2, 80)];
    view1.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label.text = @"美食狂欢";
    label.font = [UIFont boldSystemFontOfSize:17];
    [view1 addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 100, 30)];
    label2.text = @"吃到爽省到爆";
    label2.font = [UIFont boldSystemFontOfSize:12];
    [view1 addSubview:label2];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 55 , 8, 48, 48)];
    imageView.image = [UIImage imageNamed:@"row_3_1.png"];
    [view1 addSubview:imageView];
    
    //--------------view2---------
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(3, 169, kScreenWidth/2 - 2, 80)];
    view2.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label3.text = @"麦霸开唱";
    label3.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 100, 30)];
    label4.text = @"嗨歌无极限";
    label4.font = [UIFont boldSystemFontOfSize:12];
    [view2 addSubview:label4];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 55 , 8, 48, 48)];
    imageView2.image = [UIImage imageNamed:@"row_3_2.png"];
    [view2 addSubview:imageView2];
    
    //-------View3-------
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(3, 252, kScreenWidth/2 - 2, 80)];
    view3.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view3];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label5.text = @"到店付买单";
    label5.font = [UIFont boldSystemFontOfSize:17];
    [view3 addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 100, 30)];
    label6.text = @"省钱又便捷";
    label6.font = [UIFont boldSystemFontOfSize:12];
    [view3 addSubview:label6];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 55 , 8, 48, 48)];
    imageView3.image = [UIImage imageNamed:@"row_3_3.png"];
    [view3 addSubview:imageView3];
    
    //-------View4-------
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 5, 86, kScreenWidth/2 - 7, 164)];
    view4.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view4];
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label7.text = @"我是证人";
    label7.font = [UIFont boldSystemFontOfSize:17];
    [view4 addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 120, 30)];
    label8.text = @"看电影16.6元起";
    label8.font = [UIFont boldSystemFontOfSize:12];
    [view4 addSubview:label8];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/2 - 96)/ 2 , 66, 96, 96)];
    imageView4.image = [UIImage imageNamed:@"row_3_4.png"];
    [view4 addSubview:imageView4];
    
    //-------View5-------
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 5, 252, kScreenWidth/2 - 7, 80)];
    view5.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [_row3View addSubview:view5];
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    label9.text = @"洋气！来学";
    label9.font = [UIFont boldSystemFontOfSize:17];
    [view5 addSubview:label9];
    
    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 100, 30)];
    label10.text = @"储值卡尊享";
    label10.font = [UIFont boldSystemFontOfSize:12];
    [view5 addSubview:label10];
    
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 55 , 8, 48, 48)];
    imageView5.image = [UIImage imageNamed:@"row_3_5.png"];
    [view5 addSubview:imageView5];
    
    
    
}


#pragma mark - 精选抢购
- (void)_createSecondView{
    
    _SecondView = [[UIView alloc] init];
    _SecondView.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = (kScreenWidth - 120)/3;
    
    for (int i = 0; i < 3; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(30 + (width+30) * i, 45, width, 60)];
        
        image.backgroundColor = [UIColor yellowColor];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"Second%d",i +1]];
        
        [_SecondView addSubview:image];
    }
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 2; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30 + (width+30) * i, 110 + j * 23, width, 20)];
            label.backgroundColor = [UIColor whiteColor];
            
            if (j == 0) {
                NSArray *array = @[@"星洲蕉叶",
                                   @"十二天堂寿喜烧",
                                   @"知味观餐厅"
                                   ];
                label.text = array[i];
            }
            if (j == 1) {
                
            }
            
            label.font = [UIFont boldSystemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            
            [_SecondView addSubview:label];
            
        }
    }
    
}

#pragma mark - 分类视图:美食、电影等
- (void)_createClassifyView{
    
    _ClassifyView = [[UIView alloc] init];
    _ClassifyView.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = (kScreenWidth - 48) / 5 ;
    CGFloat height = (160 - 18) / 2 ;
    
    NSArray *labelNames = @[@"美食",
                            @"电影",
                            @"酒店",
                            @"KTV",
                            @"外卖",
                            @"储值卡",
                            @"到店付",
                            @"代金券",
                            @"旅游",
                            @"更多"
                            ];
    
    
    
    for (int i = 0; i < 5; i++) {
        
        for (int j = 0; j < 2; j++) {
            
            _button = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * (width + 5), 5 + j * (height + 5), width, height)];
            
            [_button setBackgroundColor:[UIColor whiteColor]];
            [_ClassifyView addSubview:_button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, width, 30)];
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:12];
            
            [_button addSubview:label];
            
            if (j == 0) {
                [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classify%d",i * (j+1)+1]] forState:UIControlStateNormal];
                label.text = labelNames[i * (j+1)];
                
            }else if(j == 1){
                [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classify%d",i * j + 6]] forState:UIControlStateNormal];
                label.text = labelNames[i * j + 5];
            }
            
            //设置图片偏移量
            [_button setImageEdgeInsets:UIEdgeInsetsMake(0, 9, 35, 10)];
        }
        
    }
    
    
}

#pragma mark - 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取最终的偏移量
    CGFloat offX = scrollView.contentOffset.x;
    
    
    //计算当前的页数
    NSInteger index =  offX / kScreenWidth;
    
    
    //修改pageControl的currentPage
    _pageCtrl.currentPage = index;
    
    
    
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
