//
//  countryInfoCell.h
//  SearchInTable
//
//  Created by Mac on 18.07.15.
//  Copyright (c) 2015 Mac. All rights reserved.


#import <UIKit/UIKit.h>

@class CountryInfo;


@interface countryInfoCell : UITableViewCell
-(void)setupWithModel:(CountryInfo*)model;

@end
