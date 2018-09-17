//
//  YQTextView.h
//  YQTextView_Example
//
//  Created by WYQ on 2018/9/17.
//  Copyright © 2018 wyqpadding@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQTextView : UITextView
@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;
- (void)refreshPlaceholder;

@end

NS_ASSUME_NONNULL_END
