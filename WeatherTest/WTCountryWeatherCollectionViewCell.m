//
//  WTCountryWeatherCollectionViewCell.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTCountryWeatherCollectionViewCell.h"
#import "WTWeather.h"

@interface WTCountryWeatherCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation WTCountryWeatherCollectionViewCell

- (void)awakeFromNib {
    self.removeButton.alpha = 0;
    self.cityName.text = self.weatherLabel.text = self.weatherDescLabel.text = self.temperatureLabel.text = @"-";
    
}

#pragma mark - Weather City
- (void)setWeatherCity:(WTWeatherCity *)weatherCity {
    _weatherCity = weatherCity;
    self.cityName.text = weatherCity.cityName;
    if (weatherCity.weather) {
        [self updateWeather];
    } else {
        self.weatherLabel.text = self.weatherDescLabel.text = self.temperatureLabel.text = @"-";
    }
        
    [self updateTime];
    
    [self layoutIfNeeded];
    
    //Add shadow
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 1.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;
    [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bounds] CGPath]];}

- (void)updateWeather {
    self.weatherLabel.text = self.weatherCity.weather.main;
    self.weatherDescLabel.text = self.weatherCity.weather.desc;
    self.temperatureLabel.text = [self.weatherCity.weather.temp.stringValue stringByAppendingString:@"\u00B0C"];
    
}

- (void)updateTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    self.lastUpdateLabel.text = [formatter stringFromDate:self.weatherCity.lastUpdate];
}

#pragma mark - Remove mode
- (void)setRemoveMode:(BOOL)removeMode {
    _removeMode = removeMode;
    [UIView animateWithDuration:0.5 animations:^{
        self.removeButton.alpha = removeMode;
    }];
}

- (IBAction)removeButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(removeCity:)]) {
        [self.delegate removeCity:self.weatherCity];
    }
}
@end
