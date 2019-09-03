//
//  DUXBetaDashboardWidget.m
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

#import "DUXBetaDashboardWidget.h"
#import "DUXBetaCompassWidget.h"
#import "DUXBetaHomeDistanceWidget.h"
#import "DUXBetaAltitudeWidget.h"
#import "DUXBetaHorizontalVelocityWidget.h"
#import "DUXBetaVerticalVelocityWidget.h"
#import "DUXBetaVPSWidget.h"
#import "DUXBetaRCDistanceWidget.h"
#import "UIImage+DUXBetaAssets.h"
#import "UIFont+DUXBetaFonts.h"
@import DJIUXSDKCore;

static CGSize const kDesignSize = {255.0, 50.0};



@implementation DUXBetaDashboardWidget

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateUI];
}

- (void)setupUI {
    self.locationManagerAccuracy = kCLLocationAccuracyBestForNavigation;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Setting up background views
    self.topStackBackgroundView = [UIView new];
    self.bottomStackBackgroundView = [UIView new];
    self.topStackBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.bottomStackBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

    // Setting up widgets
    self.compassWidget = [[DUXBetaCompassWidget alloc] init];
    self.homeDistanceWidget = [[DUXBetaHomeDistanceWidget alloc] init];
    self.altitudeWidget = [[DUXBetaAltitudeWidget alloc] init];
    self.rcDistanceWidget = [[DUXBetaRCDistanceWidget alloc] init];
    self.horizontalVelocityWidget = [[DUXBetaHorizontalVelocityWidget alloc] init];
    self.verticalVelocityWidget = [[DUXBetaVerticalVelocityWidget alloc] init];
    self.vpsWidget = [[DUXBetaVPSWidget alloc] init];
    
    // Preparing for autolayout
    self.topStackBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomStackBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.compassWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.homeDistanceWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.altitudeWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.rcDistanceWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.horizontalVelocityWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.verticalVelocityWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.vpsWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.compassWidget installInViewController:self];

    [self.homeDistanceWidget installInViewController:self
                    insideSubview:self.topStackBackgroundView];
    [self.altitudeWidget installInViewController:self
                    insideSubview:self.topStackBackgroundView];
    [self.rcDistanceWidget installInViewController:self
                                insideSubview:self.topStackBackgroundView];
    [self.horizontalVelocityWidget installInViewController:self
                    insideSubview:self.bottomStackBackgroundView];
    [self.verticalVelocityWidget installInViewController:self
                    insideSubview:self.bottomStackBackgroundView];
    [self.vpsWidget installInViewController:self
                    insideSubview:self.bottomStackBackgroundView];
    
    [self.view addSubview: self.topStackBackgroundView];
    [self.view addSubview: self.bottomStackBackgroundView];
    
    // Adding relevant layout guides
    UILayoutGuide *compassWidgetPaddingGuide = [UILayoutGuide new];
    [self.view addLayoutGuide:compassWidgetPaddingGuide];
    
    UILayoutGuide *topStackPaddingGuide1 = [UILayoutGuide new];
    UILayoutGuide *topStackPaddingGuide2 = [UILayoutGuide new];
    UILayoutGuide *topStackPaddingGuide3 = [UILayoutGuide new];
    UILayoutGuide *topStackPaddingGuide4 = [UILayoutGuide new];
    [self.topStackBackgroundView addLayoutGuide:topStackPaddingGuide1];
    [self.topStackBackgroundView addLayoutGuide:topStackPaddingGuide2];
    [self.topStackBackgroundView addLayoutGuide:topStackPaddingGuide3];
    [self.topStackBackgroundView addLayoutGuide:topStackPaddingGuide4 ];
    
    UILayoutGuide *bottomStackPaddingGuide1 = [UILayoutGuide new];
    UILayoutGuide *bottomStackPaddingGuide2 = [UILayoutGuide new];
    UILayoutGuide *bottomStackPaddingGuide3 = [UILayoutGuide new];
    UILayoutGuide *bottomStackPaddingGuide4 = [UILayoutGuide new];
    [self.bottomStackBackgroundView addLayoutGuide:bottomStackPaddingGuide1];
    [self.bottomStackBackgroundView addLayoutGuide:bottomStackPaddingGuide2];
    [self.bottomStackBackgroundView addLayoutGuide:bottomStackPaddingGuide3];
    [self.bottomStackBackgroundView addLayoutGuide:bottomStackPaddingGuide4];
    
    // Aspect ratios
    double compassWidgetAspectRatio = [self.compassWidget widgetSizeHint].preferredAspectRatio;
    double homeDistanceWidgetAspectRatio = [self.homeDistanceWidget widgetSizeHint].preferredAspectRatio;
    double altitudeWidgetAspectRatio = [self.altitudeWidget widgetSizeHint].preferredAspectRatio;
    double rcDistanceWidgetAspectRatio = [self.rcDistanceWidget widgetSizeHint].preferredAspectRatio;
    double horizontalVelocityWidgetAspectRatio = [self.horizontalVelocityWidget widgetSizeHint].preferredAspectRatio;
    double verticalVelocityWidgetAspectRatio = [self.verticalVelocityWidget widgetSizeHint].preferredAspectRatio;
    double vpsWidgetAspectRatio = [self.vpsWidget widgetSizeHint].preferredAspectRatio;
    
    // Autolayout
    [self.compassWidget.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.compassWidget.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.compassWidget.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.compassWidget.view.widthAnchor constraintEqualToAnchor:self.compassWidget.view.heightAnchor multiplier:compassWidgetAspectRatio].active = YES;
    
    [compassWidgetPaddingGuide.leftAnchor constraintEqualToAnchor:self.compassWidget.view.rightAnchor].active = YES;
    [compassWidgetPaddingGuide.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [compassWidgetPaddingGuide.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [compassWidgetPaddingGuide.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.01].active = YES;
    
    [self.topStackBackgroundView.leftAnchor constraintEqualToAnchor:compassWidgetPaddingGuide.rightAnchor].active = YES;
    [self.topStackBackgroundView.bottomAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.topAnchor].active = YES;
    [self.topStackBackgroundView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.32].active = YES;
    
    [self.bottomStackBackgroundView.leftAnchor constraintEqualToAnchor:compassWidgetPaddingGuide.rightAnchor].active = YES;
    [self.bottomStackBackgroundView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.bottomStackBackgroundView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.28].active = YES;
    
    
    [topStackPaddingGuide1.leftAnchor constraintEqualToAnchor:self.topStackBackgroundView.leftAnchor].active = YES;
    [topStackPaddingGuide1.rightAnchor constraintEqualToAnchor:self.homeDistanceWidget.view.leftAnchor].active = YES;
    [topStackPaddingGuide1.topAnchor constraintEqualToAnchor:self.topStackBackgroundView.topAnchor].active = YES;
    [topStackPaddingGuide1.bottomAnchor constraintEqualToAnchor:self.topStackBackgroundView.bottomAnchor].active = YES;
    [topStackPaddingGuide1.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.01].active = YES;
    
    [topStackPaddingGuide2.leftAnchor constraintEqualToAnchor:self.homeDistanceWidget.view.rightAnchor].active = YES;
    [topStackPaddingGuide2.rightAnchor constraintEqualToAnchor:self.altitudeWidget.view.leftAnchor].active = YES;
    [topStackPaddingGuide2.topAnchor constraintEqualToAnchor:self.topStackBackgroundView.topAnchor].active = YES;
    [topStackPaddingGuide2.bottomAnchor constraintEqualToAnchor:self.topStackBackgroundView.bottomAnchor].active = YES;
    [topStackPaddingGuide2.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.01].active = YES;
    
    [topStackPaddingGuide3.leftAnchor constraintEqualToAnchor:self.altitudeWidget.view.rightAnchor].active = YES;
    [topStackPaddingGuide3.rightAnchor constraintEqualToAnchor:self.rcDistanceWidget.view.leftAnchor].active = YES;
    [topStackPaddingGuide3.topAnchor constraintEqualToAnchor:self.topStackBackgroundView.topAnchor].active = YES;
    [topStackPaddingGuide3.bottomAnchor constraintEqualToAnchor:self.topStackBackgroundView.bottomAnchor].active = YES;
    [topStackPaddingGuide3.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.01].active = YES;
    
    [topStackPaddingGuide4.leftAnchor constraintEqualToAnchor:self.rcDistanceWidget.view.rightAnchor].active = YES;
    [topStackPaddingGuide4.rightAnchor constraintEqualToAnchor:self.topStackBackgroundView.rightAnchor].active = YES;
    [topStackPaddingGuide4.topAnchor constraintEqualToAnchor:self.topStackBackgroundView.topAnchor].active = YES;
    [topStackPaddingGuide4.bottomAnchor constraintEqualToAnchor:self.topStackBackgroundView.bottomAnchor].active = YES;
    [topStackPaddingGuide4.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.01].active = YES;
    
    
    [self.rcDistanceWidget.view.widthAnchor constraintEqualToAnchor:self.rcDistanceWidget.view.heightAnchor multiplier:rcDistanceWidgetAspectRatio].active = YES;
    [self.rcDistanceWidget.view.heightAnchor constraintEqualToAnchor:self.topStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.rcDistanceWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.topStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;

    [self.homeDistanceWidget.view.widthAnchor constraintEqualToAnchor:self.homeDistanceWidget.view.heightAnchor multiplier:homeDistanceWidgetAspectRatio].active = YES;
    [self.homeDistanceWidget.view.heightAnchor constraintEqualToAnchor:self.topStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.homeDistanceWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.topStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;

    [self.altitudeWidget.view.widthAnchor constraintEqualToAnchor:self.altitudeWidget.view.heightAnchor multiplier:altitudeWidgetAspectRatio].active = YES;
    [self.altitudeWidget.view.heightAnchor constraintEqualToAnchor:self.topStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.altitudeWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.topStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;
    
    [bottomStackPaddingGuide1.leftAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.leftAnchor].active = YES;
    [bottomStackPaddingGuide1.rightAnchor constraintEqualToAnchor:self.horizontalVelocityWidget.view.leftAnchor].active = YES;
    [bottomStackPaddingGuide1.topAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.topAnchor].active = YES;
    [bottomStackPaddingGuide1.bottomAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.bottomAnchor].active = YES;
    [bottomStackPaddingGuide1.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.02].active = YES;
    
    [bottomStackPaddingGuide2.leftAnchor constraintEqualToAnchor:self.horizontalVelocityWidget.view.rightAnchor].active = YES;
    [bottomStackPaddingGuide2.rightAnchor constraintEqualToAnchor:self.verticalVelocityWidget.view.leftAnchor].active = YES;
    [bottomStackPaddingGuide2.topAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.topAnchor].active = YES;
    [bottomStackPaddingGuide2.bottomAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.bottomAnchor].active = YES;
    [bottomStackPaddingGuide2.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.02].active = YES;
    
    [bottomStackPaddingGuide3.leftAnchor constraintEqualToAnchor:self.verticalVelocityWidget.view.rightAnchor].active = YES;
    [bottomStackPaddingGuide3.rightAnchor constraintEqualToAnchor:self.vpsWidget.view.leftAnchor].active = YES;
    [bottomStackPaddingGuide3.topAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.topAnchor].active = YES;
    [bottomStackPaddingGuide3.bottomAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.bottomAnchor].active = YES;
    [bottomStackPaddingGuide3.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.02].active = YES;
    
    [bottomStackPaddingGuide4.leftAnchor constraintEqualToAnchor:self.vpsWidget.view.rightAnchor].active = YES;
    [bottomStackPaddingGuide4.rightAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.rightAnchor].active = YES;
    [bottomStackPaddingGuide4.topAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.topAnchor].active = YES;
    [bottomStackPaddingGuide4.bottomAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.bottomAnchor].active = YES;
    [bottomStackPaddingGuide4.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.02].active = YES;
    
    [self.verticalVelocityWidget.view.widthAnchor constraintEqualToAnchor:self.verticalVelocityWidget.view.heightAnchor multiplier:verticalVelocityWidgetAspectRatio].active = YES;
    [self.verticalVelocityWidget.view.heightAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.verticalVelocityWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.bottomStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;
    
    [self.horizontalVelocityWidget.view.widthAnchor constraintEqualToAnchor:self.horizontalVelocityWidget.view.heightAnchor multiplier:horizontalVelocityWidgetAspectRatio].active = YES;
    [self.horizontalVelocityWidget.view.heightAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.horizontalVelocityWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.bottomStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;
    
    [self.vpsWidget.view.widthAnchor constraintEqualToAnchor:self.vpsWidget.view.heightAnchor multiplier:vpsWidgetAspectRatio].active = YES;
    [self.vpsWidget.view.heightAnchor constraintEqualToAnchor:self.bottomStackBackgroundView.heightAnchor multiplier:0.65].active = YES;
    [self.vpsWidget.view.centerYAnchor constraintEqualToSystemSpacingBelowAnchor:self.bottomStackBackgroundView.centerYAnchor multiplier:0.9].active = YES;
}

- (void)updateUI {
    CGFloat radius = self.view.frame.size.height * 0.05;

    UIBezierPath *topRoundedPath = [UIBezierPath bezierPathWithRoundedRect:self.topStackBackgroundView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *topShapeLayer = [[CAShapeLayer alloc] init];
    [topShapeLayer setPath:topRoundedPath.CGPath];
    self.topStackBackgroundView.layer.mask = topShapeLayer;
    
    UIBezierPath *bottomRoundedPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomStackBackgroundView.bounds byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomRoundedPath.CGPath];
    self.bottomStackBackgroundView.layer.mask = bottomShapeLayer;
    

    //added to update text fields
    [self.altitudeWidget updateUI];
    [self.vpsWidget updateUI];
    [self.verticalVelocityWidget updateUI];
    [self.horizontalVelocityWidget updateUI];
    [self.rcDistanceWidget updateUI];
    [self.homeDistanceWidget updateUI];

    
    
}

-(void)setLocationManagerAccuracy:(CLLocationAccuracy)locationManagerAccuracy {
    _locationManagerAccuracy = locationManagerAccuracy;
    if (self.compassWidget) {
        self.compassWidget.widgetModel.locationManagerAccuracy = _locationManagerAccuracy;
    }
}

- (DUXBetaWidgetSizeHint)widgetSizeHint {
    DUXBetaWidgetSizeHint hint = {kDesignSize.width / kDesignSize.height, kDesignSize.width, kDesignSize.height};
    return hint;
}

@end
