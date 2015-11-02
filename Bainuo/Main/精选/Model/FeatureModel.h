//
//  FeatureModel.h
//  Bainuo
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeatureModel : NSObject
@property (nonatomic,copy) NSString *featureDescription;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *market_price;
@property (nonatomic,copy) NSString *current_price;
@property (nonatomic,copy) NSString *sale_num;
@property (nonatomic,copy) NSString *deal_murl;


//- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
