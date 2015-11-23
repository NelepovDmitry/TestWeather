//
//  WTManageCityViewController.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTManageCityViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface WTManageCityViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    GMSPlacesClient *_placesClient;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *autoCompleteCity;

@end

@implementation WTManageCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [GMSPlacesClient sharedClient];
}

#pragma mark - Search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (!searchText.length) {
        return;
    }
    __weak typeof(self) wSelf = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    [_placesClient autocompleteQuery:searchText bounds:nil filter:filter callback:^(NSArray * _Nullable results, NSError * _Nullable error) {
        wSelf.autoCompleteCity = [results copy];
        [wSelf.tableView reloadData];
    }];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.autoCompleteCity.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *retCell =  [tableView dequeueReusableCellWithIdentifier:@"City"];
    if (!retCell) {
        retCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"City"];
    }
    GMSAutocompletePrediction *pred = self.autoCompleteCity[indexPath.row];
    retCell.textLabel.attributedText = pred.attributedFullText;
    
    return retCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GMSAutocompletePrediction *pred = self.autoCompleteCity[indexPath.row];
    //Noot good
    NSArray *nameFormatted = [pred.attributedFullText.string componentsSeparatedByString:@","];
    if (nameFormatted.count > 2) {
        NSString *cityName = nameFormatted[0];
        NSString *countyCode = nameFormatted[1];
        [self loadingWeatherInfo:cityName];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[@"Not found weather info for city " stringByAppendingString:pred.attributedFullText.string] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}

- (void)loadingWeatherInfo:(NSString *)cityName {
    __weak typeof(self) wSelf = self;
    [WTWeatherCity weatherForCity:cityName responseBlock:^(WTWeatherCity *weatherCity) {
        if (weatherCity) {
            [wSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[@"Not found weather info for city " stringByAppendingString:cityName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

@end
