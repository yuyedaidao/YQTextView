//
//  YQTextView.m
//  YQTextView_Example
//
//  Created by WYQ on 2018/9/17.
//  Copyright © 2018 wyqpadding@gmail.com. All rights reserved.
//

#import "YQTextView.h"

@interface YQTextView()
@property (strong, nonatomic) UILabel *placeHolderLabel;
@end

@implementation YQTextView
@synthesize placeholder = _placeholder;
-(void)initialize {
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _placeHolderLabel.numberOfLines = 1;
    _placeHolderLabel.font = self.font;
    _placeHolderLabel.backgroundColor = [UIColor clearColor];
    _placeHolderLabel.textColor = self.placeholderColor ? self.placeholderColor : [UIColor colorWithWhite:0.7 alpha:1.0];
    _placeHolderLabel.text = self.placeholder;
    _placeHolderLabel.textAlignment = self.textAlignment;
    [self addSubview:_placeHolderLabel];
    [self sendSubviewToBack:_placeHolderLabel];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self initialize];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)refreshPlaceholder {
    self.placeHolderLabel.hidden = (self.text.length > 0 || self.attributedText.length > 0);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self refreshPlaceholder];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self refreshPlaceholder];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolderLabel.font = self.font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.placeHolderLabel.textAlignment = textAlignment;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_placeholder.length) {
        UIEdgeInsets insets = self.textContainerInset;
        CGFloat height = [self placeholderSize].height;
        self.placeHolderLabel.frame = CGRectMake(insets.left + self.textContainer.lineFragmentPadding, insets.top, self.bounds.size.width - (insets.left + self.textContainer.lineFragmentPadding + insets.right), height);
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        _placeHolderLabel.text = self.placeholder;
        [self refreshPlaceholder];
    }
}

- (CGSize)placeholderSize {
    return [_placeholder boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
-(id<UITextViewDelegate>)delegate {
    [self refreshPlaceholder];
    return [super delegate];
}

@end
