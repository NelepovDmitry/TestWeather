//
//  WTCountryWeatherCollectionViewCell.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTCountryWeatherCollectionViewCellDelegate;

@interface WTCountryWeatherCollectionViewCell : UICollectionViewCell

@property (nonatomic) WTWeatherCity *weatherCity;
@property (nonatomic) BOOL removeMode;

@property (nonatomic, weak) id<WTCountryWeatherCollectionViewCellDelegate> delegate;

@end

@protocol WTCountryWeatherCollectionViewCellDelegate <NSObject>

- (void)removeCity:(WTWeatherCity *)weatherCity;

@end