//
//  FeaturedCell.h
//  Bainuo
//
//  Created by Mac on 15/10/29.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureModel.h"

@interface FeaturedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *webImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *current_priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *market_priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *sale_numLabel;

@property (nonatomic,strong) FeatureModel *model;
@end
