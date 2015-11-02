//
//  FeaturedCell.m
//  Bainuo
//
//  Created by Mac on 15/10/29.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "FeaturedCell.h"
#import "UIImageView+WebCache.h"

@implementation FeaturedCell



-(void)setModel:(FeatureModel *)model
{
    _model = model;
//    _descriptionLabel.text = _model.featureDescription;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _descriptionLabel.text = self.model.featureDescription;
    _titleLabel.text = _model.title;
    _market_priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.market_price];
    _current_priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.current_price];
    _sale_numLabel.text = [NSString stringWithFormat:@"售%@",_model.sale_num];
    _scoreLabel.text = [NSString stringWithFormat:@"%@分",_model.score];
    
//    _titleLabel.textColor = [UIColor blackColor];
    //应该缩小图片,待修改
    NSURL *url = [NSURL URLWithString:_model.imageName];
    [_webImageVIew sd_setImageWithURL:url];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
