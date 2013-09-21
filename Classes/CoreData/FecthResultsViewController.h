//
//  FecthResultsViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FecthResultsViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
}

@end
