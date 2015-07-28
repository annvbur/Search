//
// Created by Mac on 18.07.15.
// Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CountryInfo : NSObject   //наследуется отобджекта
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *isoCode;

- (instancetype)initWithName:(NSString *)name countryCode:(NSString *)countryCode isoCode:(NSString *)isoCode;

+ (instancetype)infoWithName:(NSString *)name countryCode:(NSString *)countryCode isoCode:(NSString *)isoCode;

@end