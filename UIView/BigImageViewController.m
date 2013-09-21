    //
//  BigImageViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-12-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BigImageViewController.h"
#import "UIBigImageView.h"

@implementation BigImageViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (id)initWithFrame:(CGRect)frame andVC:(id)viewController andImageArr:(NSArray *)imageArr andIndex:(NSInteger)index
{
    self = [super init];
    if (self)
    {
        isViewAlloc = YES;
        UIBigImageView *bigImageV = [[[UIBigImageView alloc] initWithFrame:frame] autorelease];
        self.view = bigImageV;
        [bigImageV setImageArr:imageArr andSelIndex:index];
        bigImageV.aViewController = viewController;
        [bigImageV beginAnimation];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    NSLog(@"shouldAutorotateToInterfaceOrientation");
    if (!isViewAlloc)
    {
        UIBigImageView *bingImageV = (UIBigImageView *)self.view;
        bingImageV.isDrag = NO;
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
            [bingImageV resetSelfBounds:CGRectMake(0, 0, 480, 320)];
        }
        else if (interfaceOrientation == UIInterfaceOrientationPortrait || 
                 interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [bingImageV resetSelfBounds:CGRectMake(0, 0, 320, 480)];
        }  
    }
    isViewAlloc = NO;
    if (interfaceOrientation == UIInterfaceOrientationPortrait || 
        interfaceOrientation == UIInterfaceOrientationLandscapeRight || 
        interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
