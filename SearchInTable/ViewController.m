//
//  ViewController.m
//  SearchInTable
//
//  Created by Mac on 18.07.15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ViewController.h"
#import "libPhoneNumber-iOS/NBPhoneNumberUtil.h"
#import "CountryInfo.h"
#import "countryInfoCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *countryInfoList;
@property(nonatomic) BOOL isSearchMode;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSArray *searchResults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"countryInfoCell" bundle:nil]
    forCellReuseIdentifier:@"CountryInfoCell"];
}

-(void)loadData{
    //get list of iso country codes
    NSArray *CountryCodeArray = [NSLocale ISOCountryCodes];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:CountryCodeArray.count];

    //get list of preferred  languages available for device
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *languageId =languages.firstObject;
    //create locale object based on preferred language id
    NSLocale *preferredLocale = [NSLocale localeWithLocaleIdentifier:languageId];

    for (NSString *isoCountryCode in CountryCodeArray){
        NSString *countryName = [preferredLocale displayNameForKey:NSLocaleCountryCode value:isoCountryCode];

        NBPhoneNumberUtil * util = [NBPhoneNumberUtil sharedInstance];
        NSNumber * phoneCountryCode = [util getCountryCodeForRegion:isoCountryCode];
        NSString* phoneCountryCodeString= [NSString stringWithFormat:@"+%d", phoneCountryCode.intValue];


        CountryInfo* info = [[CountryInfo alloc] initWithName:countryName countryCode:phoneCountryCodeString isoCode:isoCountryCode];
        [result addObject:info];


    }

    NSArray *sortedArray = [result sortedArrayUsingComparator:^NSComparisonResult(CountryInfo *obj1, CountryInfo *obj2){
        return [obj1.name localizedCaseInsensitiveCompare:obj2.name];
    }];
    self.countryInfoList = sortedArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isSearchMode ? self.searchResults.count : self.countryInfoList.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    countryInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CountryInfoCell" forIndexPath:indexPath];
    NSArray *dataSource = self.isSearchMode ? self.searchResults : self.countryInfoList;
    CountryInfo *model = dataSource[indexPath.row];
    [cell setupWithModel:model];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeSearchMode:(UIButton *)sender {
    self.isSearchMode = !self.isSearchMode;
    if(self.isSearchMode){
        [sender setTitle:@"Done" forState:UIControlStateNormal];


     self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
     self.searchController.searchResultsUpdater = self;
     self.searchController.delegate = self;
     self.searchController.dimsBackgroundDuringPresentation = NO;
     self.searchController.hidesNavigationBarDuringPresentation = NO;

        [self.tableView setTableHeaderView: self.searchController.searchBar];

        [self presentViewController:self.searchController animated:YES completion:^{
            [self.searchController.searchBar becomeFirstResponder];
        }];
    }else{
        [sender setTitle:@"Search" forState:UIControlStateNormal];
        [self.tableView setTableHeaderView:nil];
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchText = searchController.searchBar.text;

    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(CountryInfo *info, NSDictionary *bindings) {

        NSRange rangeInName = [info.name rangeOfString:searchText options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
        NSRange rangeInCode = [info.countryCode rangeOfString:searchText options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
        
        BOOL predicateResult = rangeInName.location!=NSNotFound || rangeInCode.location!=NSNotFound;
        return predicateResult;
    }];

    if(searchText.length>0){
        self.searchResults = [self.countryInfoList filteredArrayUsingPredicate:predicate];
    }else{
        self.searchResults = self.countryInfoList;
    }

    [self.tableView reloadData];

}

@end
