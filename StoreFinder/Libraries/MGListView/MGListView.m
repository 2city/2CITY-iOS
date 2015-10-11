//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGListView.h"

@implementation MGListView

@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize cellHeight;
@synthesize nibName = _nibName;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize arrayData = _arrayData;
@synthesize object;
@synthesize selectedIndex;
@synthesize isCustomCell;
@synthesize noOfItems;
@synthesize refreshControl;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _nibName = [@"MGListView" copy];
        _nibContents = [[NSBundle mainBundle] loadNibNamed:_nibName
                                                     owner:self
                                                    options:nil];
        
        self = [_nibContents objectAtIndex:0];
        [self baseInit];
    }
    return self;
}

-(void) baseInit {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    isCustomCell = NO;
    noOfItems = 0;
    refreshControl = [[UIRefreshControl alloc] init];
    
}

-(void)addSubviewRefreshControlWithTintColor:(UIColor*)color {
    
    if(color != nil)
        [refreshControl setTintColor:color];
    
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

-(void)refresh:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(MGListView:didRefreshStarted:)]) {
        [self.delegate MGListView:self didRefreshStarted:refreshControl];
    }
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialization code
    }
    return self;
}

-(void)registerNibName:(NSString*)nibName cellIndentifier:(NSString *)cellIdentifier {
    _nibName = [nibName copy];
    _cellIdentifier = [cellIdentifier copy];
    [self.tableView registerNib:[UINib nibWithNibName:_nibName bundle:nil] forCellReuseIdentifier:_cellIdentifier];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView * view in [self subviews]) {
        if (view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(noOfItems > 0) {
        return noOfItems;
    }
    
    return _arrayData.count;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MGListCell *cell = (MGListCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self.delegate MGListView:self didSelectCell:cell indexPath:indexPath];
    selectedIndex = indexPath.row;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGListCell* cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if(cellHeight > 0)
        return cellHeight;
    
    else
        return [self.delegate MGListView:self cell:cell heightForRowAtIndexPath:indexPath];
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGListCell* cell;
    
    if(!isCustomCell) {
//        [tableView registerNib:[UINib nibWithNibName:_nibName bundle:nil] forCellReuseIdentifier:_cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        
        [self.delegate MGListView:self didCreateCell:cell indexPath:indexPath];
        return cell;
    }
    
    return [self.delegate MGListView:self didCreateCell:cell indexPath:indexPath];
}

-(void)setSelectedList:(NSInteger)index {
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self tableView:_tableView didSelectRowAtIndexPath:indexPath];
}

-(void)reloadData {
    [self.tableView registerNib:[UINib nibWithNibName:_nibName bundle:nil] forCellReuseIdentifier:_cellIdentifier];
    
    [self.tableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate MGListView:self scrollViewDidScroll:scrollView];
}

@end
