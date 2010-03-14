//
//  BPStaticListSelectionViewController.h
//
//  Created by Jon Olson on 9/30/09.
//  Copyright 2009 Ballistic Pigeon, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BPListSelectionLabel;
extern NSString * const BPListSelectionValue;
extern NSString * const BPListSelectionImageName;

extern NSDictionary *BPListSelectionItem(NSString *label, id value);
extern NSDictionary *BPImageListSelectionItem(NSString *label, NSString *imageName, id value);

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
- (id)initWithOptions:(NSArray *)someOptions style:(UITableViewStyle)style;

@end


@interface NSObject (BPStaticListSelectionViewControllerDelegate)

- (void)listSelection:(BPStaticListSelectionViewController *)listSelection didSelectValue:(id)value;

@end