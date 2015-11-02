//
//  FeaturedTableView.m
//  Bainuo
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "FeaturedTableView.h"
#import "FeaturedCell.h"
#import "DetailViewController.h"
#import "FeaturedViewController.h"
#import "FeatureModel.h"

@implementation FeaturedTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}



- (void)_initViews {
    self.delegate = self;
    self.dataSource = self;
//    [self registerClass:[FeaturedCell class] forCellReuseIdentifier:@"FeaturedCell"];
    UINib *nib = [UINib nibWithNibName:@"FeaturedCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"Cell"];
}

//- (void)setStoryModelArray:(NSArray *)storyModelArray {
//    _storyModelArray = storyModelArray;
//    [self reloadData];
//}

- (void)setDataDicArray:(NSMutableArray *)dataDicArray {
    _dataDicArray = dataDicArray;
    [self reloadData];
}

#pragma mark - 协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%@",_dataDicArray);
//    _dataDicArray = [_dataDicArray lastObject];
    return self.dataDicArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeaturedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.model = _dataDicArray[indexPath.row];
    
    
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"每人每天每单累计优惠2份";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FeaturedViewController *fvc = (FeaturedViewController *)self.nextResponder.nextResponder;
//    NSLog(@"%@",self.nextResponder.nextResponder);
    
    DetailViewController *dvc = [[DetailViewController alloc] init];
    FeatureModel *model = [[FeatureModel alloc] init];
    model = _dataDicArray[indexPath.row];
    dvc.urlString = model.deal_murl;
    [fvc.navigationController pushViewController:dvc animated:YES];
//    [fvc presentViewController:[[DetailViewController alloc] init] animated:YES completion:nil];
}

@end
