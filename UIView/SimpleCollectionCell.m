//
//  SimpleCollectionCell.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-27.
//
//

#import "SimpleCollectionCell.h"

@implementation SimpleCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //文本
        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, frame.size.width - 40.0, 20.0)] autorelease];
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.textLabel];
        
        //图片
        UIImage *aImage = [XSTestUtils samlpeImage];
        CGFloat imageHeight = frame.size.height - self.textLabel.frame.size.height;
        CGFloat imageWidth = aImage.size.width / aImage.size.height * (frame.size.height - self.textLabel.frame.size.height);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:aImage];
        imageView.frame = CGRectMake((frame.size.width - imageWidth) / 2, self.textLabel.frame.size.height, imageWidth, imageHeight);
        [self.contentView addSubview:imageView];
        [imageView release];
        
        //边框
//        self.contentView.layer.borderWidth = 1.0f;
//        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    self.textLabel = nil;
    [super dealloc];
}

@end
