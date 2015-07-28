//
//  countryInfoCell.m
//  SearchInTable
//
//  Created by Mac on 18.07.15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "countryInfoCell.h"
#import "CountryInfo.h"

@interface countryInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *phoneCountryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;

@end


@implementation countryInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setupWithModel:(CountryInfo*)model{
    self.phoneCountryCodeLabel.text = model.countryCode;
    self.countryNameLabel.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
