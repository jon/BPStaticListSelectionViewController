//
//  BPStaticListSelectionViewController.h
//
//  Created by Jon Olson on 9/30/09.
//  Copyright 2009 Ballistic Pigeon, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BPListSelectionLabel;
extern NSString * const BPListSelectionValue;

extern NSDictionary *BPListSelectionItem(NSString *label, id value);

@interface BPStaticListSelectionViewController : UITableViewController {
	id delegate;
	
	NSArray *options;
	id value;
	
	NSInteger selectedIndex;
}

@property (assign) id delegate;
@property (retain) NSArray *options;
@property (retain) id value;

- (id)initWithOptions:(NSArray *)someOptions;

@end


@interface NSObject (BPStaticListSelectionViewControllerDelegate)

- (void)listSelection:(BPStaticListSelectionViewController *)listSelection didSelectValue:(id)value;

@end