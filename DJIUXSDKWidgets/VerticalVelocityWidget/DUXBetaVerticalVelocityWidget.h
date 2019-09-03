//
//  DUXBetaVerticalVelocityWidget.h
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

#import <DJIUXSDKWidgets/DUXBetaBaseWidget.h>
#import "DUXBetaVerticalVelocityWidgetModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Shows the vertical velocity of the aircraft.
 * Uses the unit set in the global preferences and defaults to meters.
 */
@interface DUXBetaVerticalVelocityWidget : DUXBetaBaseWidget

@property (nonatomic, strong) DUXBetaVerticalVelocityWidgetModel *widgetModel;

@property (nonatomic, strong) UIImage *upImage;
@property (nonatomic, strong) UIImage *downImage;
@property (nonatomic, strong) UIColor *lightFontColor;
@property (nonatomic, strong) UIColor *darkFontColor;
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
