//
// Created by Mac on 18.07.15.
// Copyright (c) 2015 Mac. All rights reserved.
//

#import "CountryInfo.h"


@implementation CountryInfo {

}

//comN - init With
- (instancetype)initWithName:(NSString *)name countryCode:(NSString *)countryCode isoCode:(NSString *)isoCode {
    self = [super init];
    if (self) {
        self.name = name;
        self.countryCode = countryCode;
        self.isoCode = isoCode;
    }

    return self;
}

+ (instancetype)infoWithName:(NSString *)name countryCode:(NSString *)countryCode isoCode:(NSString *)isoCode {
    return [[self alloc] initWithName:name countryCode:countryCode isoCode:isoCode];
}

@end