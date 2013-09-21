//
//  ToogleLayoutCell.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "ToogleLayoutCell.h"

@implementation ToogleLayoutCell
@synthesize imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        /*
         Returns a rectangle that is smaller or larger than the source rectangle, with the same center point.
         The rectangle is standardized and then the inset parameters are applied. If the resulting rectangle would have a negative height or width, a null rectangle is returned.
         */
        imageView = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), 5, 5)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:imageView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc
{
    [imageView release];
    [super dealloc];
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
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
