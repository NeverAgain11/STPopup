//
//  STPopupLeftBarItem.m
//  STPopup
//
//  Created by Kevin Lin on 13/9/15.
//  Copyright (c) 2015 Sth4Me. All rights reserved.
//

#import "STPopupLeftBarItem.h"

@implementation STPopupLeftBarItem
{
    UIControl *_customView;
    UIView *_bar1;
    UIView *_bar2;
    UILabel *_label;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    _customView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 58 + 18 + 18, 44)];
    if (self = [super initWithCustomView:_customView]) {
        [_customView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _bar1 = [UIView new];
        _bar1.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1];
        _bar1.userInteractionEnabled = NO;
        _bar1.layer.allowsEdgeAntialiasing = YES;
        [_customView addSubview:_bar1];
        _bar2 = [UIView new];
        _bar2.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1];
        _bar2.userInteractionEnabled = NO;
        _bar2.layer.allowsEdgeAntialiasing = YES;
        [_customView addSubview:_bar2];
        
        _label = [UILabel new];
        _label.userInteractionEnabled = false;
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = _bar1.backgroundColor;
        [_customView addSubview:_label];
        
    }
    return self;
}

//- (void)setType:(STPopupLeftBarItemType)type
//{
//    [self setType:type animated:NO];
//}

- (void)setType:(STPopupLeftBarItemType)type title:(NSString *)title animated:(BOOL)animated
{
    _type = type;
    _label.text = title;
    if (animated) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self updateLayout];
        } completion:nil];
    }
    else {
        [self updateLayout];
    }
}

- (void)updateLayout
{
    float barWidth, barHeight = 1.5, barX, bar1Y, bar2Y;
    switch (self.type) {
            case STPopupLeftBarItemCross: {
                barWidth = _customView.frame.size.height * 2 / 5;
                barX = (_customView.frame.size.width - barWidth) / 2;
                bar1Y = (_customView.frame.size.height - barHeight) / 2;
                bar2Y = bar1Y;
            }
            break;
            case STPopupLeftBarItemArrow: {
                barWidth = _customView.frame.size.height / 4;
                barX = (_customView.frame.size.width - barWidth) / 2 - barWidth / 2;
                barX = 0;
                bar1Y = (_customView.frame.size.height - barHeight) / 2 + barWidth / 2 * sin(M_PI_4);
                bar2Y = (_customView.frame.size.height - barHeight) / 2 - barWidth / 2 * sin(M_PI_4);
            }
            break;
        default:
            break;
    }
    _bar1.transform = CGAffineTransformIdentity;
    _bar2.transform = CGAffineTransformIdentity;
    _bar1.frame = CGRectMake(barX, bar1Y, barWidth, barHeight);
    _bar2.frame = CGRectMake(barX, bar2Y, barWidth, barHeight);
    
    _bar1.transform = CGAffineTransformMakeRotation(M_PI_4);
    _bar2.transform = CGAffineTransformMakeRotation(-M_PI_4);
    
    _label.frame = CGRectMake(CGRectGetMaxX(_bar1.frame) + 5, 0, _customView.frame.size.width - CGRectGetMaxX(_bar1.frame), _customView.frame.size.height);
    
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    _bar1.backgroundColor = tintColor;
    _bar2.backgroundColor = tintColor;
}

@end

