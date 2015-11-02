//
//  FeaturedTableView.h
//  Bainuo
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataDicArray;

@end
