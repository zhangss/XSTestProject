//
//  AttributedLabel.h
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import <UIKit/UIKit.h>

@interface AttributedLabel : UILabel
{
    NSMutableAttributedString *_attributeString;
    CATextLayer               *_textLayer;
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;
- (void)setColor:(UIColor *)color withText:(NSString *)str;

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

@end
