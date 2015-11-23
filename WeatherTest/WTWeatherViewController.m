//
//  WTWeatherViewController.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTWeatherViewController.h"
#import "WTCountryWeatherCollectionViewCell.h"

#import "WTManageCityViewController.h"

#import "WTLocationTracker.h"
#import "WTWeatherUpdates.h"

@interface WTWeatherViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, WTCountryWeatherCollectionViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic) BOOL removeMode;

@property (nonatomic) NSFetchedResultsController *frc;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) WTWeatherCity *cityForRemove;

@property (nonatomic) UIRefreshControl *refreshControl;
//@property (nonatomic) CLLocationManager

@end

@implementation WTWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _removeMode = NO;
    [self initNavigationBar];
    [self initCollectionView];
    [self initFRC];
    [self initLocationTracker];
    [self updateTemperatures];
}

- (void)initNavigationBar {
    self.title = @"Weather";
    
    //Add AddButton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonAction:)];
    
    //Add EditButton
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonAction:)];
}

- (void)addButtonAction:(UIBarButtonItem *)barButton {
    [self performSegueWithIdentifier:@"manageCountryListSegue" sender:barButton];
}

- (void)editButtonAction:(UIBarButtonItem *)barButton {
    self.removeMode = !self.removeMode;
    barButton.title = self.removeMode ? @"OK" : @"Edit";
}

- (void)setRemoveMode:(BOOL)removeMode {
    _removeMode = removeMode;
    [self.collectionView reloadData];
}

#pragma mark - FRC
- (void)initFRC {
    self.frc = [WTWeatherCity MR_fetchAllSortedBy:WTWeatherCityAttributes.cityName ascending:YES withPredicate:nil groupBy:nil delegate:self];
    [self.frc performFetch:nil];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}

#pragma mark - CollectionView
- (void)initCollectionView {
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WTCountryWeatherCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CountryWeather"];
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(updateTemperatures)
                  forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)updateTemperatures {
    __weak typeof(self) wSelf = self;
    [WTWeatherUpdates updateWeathers:self.frc.fetchedObjects success:^{
        [wSelf.refreshControl endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.frc.sections.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> info = self.frc.sections[section];
    return [info numberOfObjects];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    UIEdgeInsets edgeInset = [self collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:indexPath.section];
    width -= edgeInset.left;
    width -= edgeInset.right;
    width -= [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    
    width /= 2.0;
    
    
    CGSize retSize = CGSizeMake(width, width);
    return retSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTCountryWeatherCollectionViewCell *retCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CountryWeather" forIndexPath:indexPath];
    retCell.delegate = self;
    return retCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(WTCountryWeatherCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.removeMode = self.removeMode;
    cell.weatherCity = [self.frc objectAtIndexPath:indexPath];
}

#pragma mark - Delegates

#pragma mark Remove weather city
- (void)removeCity:(WTWeatherCity *)weatherCity {
    self.cityForRemove = weatherCity;
    NSString *message = [NSString stringWithFormat:@"Delete city %@ ?", weatherCity.cityName];
    
    [[[UIAlertView alloc] initWithTitle:@"Remove" message:message delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.cityForRemove MR_deleteEntity];
    }
}

#pragma mark - Location Tracker

- (void)initLocationTracker {
    [[WTLocationTracker sharedTracker] setCallbackBlock:^(id object) {
        if (![object isKindOfClass:[CLLocation class]])
            return;
        
        CLLocation *location = (CLLocation *)object;
        
        [WTWeatherCity weatherForCoordinates:location responseBlock:^(WTWeatherCity *weatherCity) {
        }];
    }];
    [[WTLocationTracker sharedTracker] startLocationTracking];
}

@end
