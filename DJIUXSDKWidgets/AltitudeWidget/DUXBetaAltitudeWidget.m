// 
//  DUXBetaAltitudeWidget.m
//  DJIUXSDK
//
//  MIT License
//  
//  Copyright © 2018-2019 DJI
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  

#import "DUXBetaAltitudeWidget.h"
#import "DUXBetaAltitudeWidgetModel.h"
#import "UIImage+DUXBetaAssets.h"
#import "UIFont+DUXBetaFonts.h"
@import DJIUXSDKCore;

static CGSize const kDesignSize = {80.0, 15.0};
static const CGFloat kLabelFontSize = 10.0;
static const CGFloat kValueFontSize = 14.0;

@interface DUXBetaAltitudeWidget ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DUXBetaAltitudeWidget

- (instancetype)init {
    self = [super init];
    if (self) {
        _lightFontColor = [UIColor duxbeta_whiteColor];
        _darkFontColor = [UIColor duxbeta_grayColor];
        _largeFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _smallFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.widgetModel = [[DUXBetaAltitudeWidgetModel alloc] init];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.widgetModel setup];
    BindRKVOModel(self.widgetModel, @selector(updateUI), altitude);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.widgetModel duxbeta_removeCustomObserver:self];
    [self.widgetModel cleanup];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupFonts];
    [self updateUI];
}

- (void)setupUI {
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.label = [UILabel new];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.label];
    
    [self.label.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.label.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.label.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.label.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
}

- (void)updateUI {
    [self.label setAttributedText: self.attributedLabelValue];
}

- (NSMutableAttributedString *)attributedLabelValue {
    NSString *kPrefix = @"H";
    NSString *valueString = [NSString stringWithFormat:@"%0.1f", self.widgetModel.altitude.doubleValue];
    NSString *kPostfix = self.widgetModel.altitudeUnits.symbol;
    NSString *basicString = [NSString stringWithFormat:@"%@ %@ %@", kPrefix, valueString, kPostfix];
    NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:basicString];
    
    NSRange prefixRange = NSMakeRange(0, kPrefix.length);
    NSRange valueRange = NSMakeRange(kPrefix.length + 1, valueString.length);
    NSRange postfixRange = NSMakeRange(kPrefix.length + valueString.length + 2, kPostfix.length);

    [labelString addAttribute:NSFontAttributeName value:self.smallFont range:prefixRange];
    [labelString addAttribute:NSForegroundColorAttributeName value:self.darkFontColor range:prefixRange];
    [labelString addAttribute:NSFontAttributeName value:self.largeFont range:valueRange];
    [labelString addAttribute:NSForegroundColorAttributeName value:self.lightFontColor range:valueRange];
    [labelString addAttribute:NSFontAttributeName value:self.smallFont range:postfixRange];
    [labelString addAttribute:NSForegroundColorAttributeName value:self.darkFontColor range:postfixRange];
    
    return labelString;
}

-(void)setupFonts {
    CGFloat smallFontSize = kLabelFontSize * MIN(self.view.frame.size.width / kDesignSize.width, self.view.frame.size.height / kDesignSize.height);
    CGFloat largeFontSize = smallFontSize * (kValueFontSize / kLabelFontSize);
    self.smallFont = [UIFont boldSystemFontOfSize:smallFontSize];
    self.largeFont = [UIFont boldSystemFontOfSize:largeFontSize];
}

- (void)setLightFontColor:(UIColor *)lightFontColor {
    _lightFontColor = lightFontColor;
    [self updateUI];
}

- (void)setDarkFontColor:(UIColor *)darkFontColor {
    _darkFontColor = darkFontColor;
    [self updateUI];
}

- (void)setSmallFont:(UIFont *)smallFont {
    _smallFont = smallFont;
    [self updateUI];
}

- (void)setLargeFont:(UIFont *)largeFont {
    _largeFont = largeFont;
    [self updateUI];
}

- (DUXBetaWidgetSizeHint)widgetSizeHint {
    DUXBetaWidgetSizeHint hint = {kDesignSize.width / kDesignSize.height, kDesignSize.width, kDesignSize.height};
    return hint;
}

@end
