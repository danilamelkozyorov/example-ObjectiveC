//
//  UIView+BottomSheetDetailView.h
//  Synergetic
//
//  Created by Мелкозеров Данила on 17.08.2022.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewDelegate <NSObject>

-(void)removeDetailView;

@end

@interface BottomSheetDetailView: UIView<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <DetailViewDelegate>delegate;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *navBarView;

-(void) setDetailInfo:(SYNDetailInfo*) setDetailInfo;

@end

NS_ASSUME_NONNULL_END
