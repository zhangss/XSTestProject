//
//  CircleLayoutCell.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "CircleLayoutCell.h"

@implementation CircleLayoutCell

@synthesize textLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:textLabel];
        
        self.contentView.layer.cornerRadius = 35.0;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.backgroundColor = [UIColor underPageBackgroundColor];
    }
    return self;
}

- (void)dealloc
{
    [textLabel release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
