//
//  BPStaticListSelectionViewController.m
//
//  Created by Jon Olson on 9/30/09.
//  Copyright 2009 Ballistic Pigeon, LLC. All rights reserved.
//

#import "BPStaticListSelectionViewController.h"

NSString * const BPListSelectionLabel = @"BPListSelectionLabel";
NSString * const BPListSelectionValue = @"BPListSelectionValue";
NSString * const BPListSelectionImageName = @"BPListSelectionImageName";

NSDictionary *BPListSelectionItem(NSString *label, id value) {
	return [NSDictionary dictionaryWithObjectsAndKeys:
	 label, BPListSelectionLabel, 
	 value, BPListSelectionValue, 
	 nil];
}

NSDictionary *BPImageListSelectionItem(NSString *label, NSString *imageName, id value) {
	return [NSDictionary dictionaryWithObjectsAndKeys:
			label, BPListSelectionLabel, 
			imageName, BPListSelectionImageName,
			value, BPListSelectionValue, 
			nil];	
}

static NSString *Label(NSDictionary *item) {
	return [item objectForKey:BPListSelectionLabel];
}

static id Value(NSDictionary *item) {
	return [item objectForKey:BPListSelectionValue];
}

static NSString *ImageName(NSDictionary *item) {
	return [item objectForKey:BPListSelectionImageName];
}

@implementation BPStaticListSelectionViewController

#pragma mark -
#pragma mark Construction and deallocation

- (id)initWithOptions:(NSArray *)someOptions style:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		options = [someOptions retain];
	}
	
	return self;
}

- (id)initWithOptions:(NSArray *)someOptions {
	return [self initWithOptions:someOptions style:UITableViewStyleGrouped];
}


- (void)dealloc {
	[options release];
	[value release];
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

@synthesize delegate, options, value;

#pragma mark Option and current selection management

- (void)updateSelectedItem:(BOOL)forced {
	if (selectedIndex >= 0)
		[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]]setAccessoryType:UITableViewCellAccessoryNone];
	selectedIndex = -1;
	if (value) {
		NSInteger currentIndex = 0;
		for (id option in options) {
			if ([Value(option) isEqual:value]) {
				selectedIndex = currentIndex;
				break;
			}
			currentIndex++;
		}
	}
		 
	if (selectedIndex >= 0) {
		[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];		
		if (!forced && [delegate respondsToSelector:@selector(listSelection:didSelectValue:)])
			[delegate listSelection:self didSelectValue:Value(I(options, selectedIndex))];
	}
}

- (void)setOptions:(NSArray *)someOptions {
	if (someOptions != options) {
		[self willChangeValueForKey:@"options"];
		[options release];
		options = [someOptions retain];
		[self didChangeValueForKey:@"options"];
		[self.tableView reloadData];
	}
}

- (void)setValue:(id)aValue {
	if (aValue != value) {
		[self willChangeValueForKey:@"value"];
		[value release];
		value = [aValue retain];
		[self didChangeValueForKey:@"value"];
		[self updateSelectedItem:YES];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self updateSelectedItem:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	NSDictionary *option = I(options, indexPath.row);
	
	cell.textLabel.text = Label(option);
	if (ImageName(option))
		cell.imageView.image = [UIImage imageNamed:ImageName(option)];
	if (indexPath.row == selectedIndex)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.value = Value(I(options, indexPath.row));
	[self updateSelectedItem:NO];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end

