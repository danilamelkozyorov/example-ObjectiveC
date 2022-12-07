//
//  UIView+BottomSheetDetailView.m
//  Synergetic
//
//  Created by Мелкозеров Данила on 17.08.2022.
//

#import "BottomSheetDetailView.h"
#import "UIColor+HexString.h"
#import "DetailViewCell.h"
#import "ScheduleViewCell.h"
#import "ImageViewCell.h"
#import "TrashTypeCell.h"

@implementation BottomSheetDetailView

UIImageView *swipeButtonImage;
UILabel *titleName;
UIButton *closeButton;
UIView *sectionView;
UIView *headerView;

SYNData *data;

- (instancetype)init {
  self = [super init];

  [self setNavBarView];
  [self setTableView];
  [self setSwipeButton];
  
  return self;
}

- (void) setDetailInfo: (SYNDetailInfo*) detailInfo {
  titleName.text = detailInfo.data.title;
  data = detailInfo.data;
}

- (void) setSwipeButton {
  swipeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipeButton"]];
  [self addSubview:swipeButtonImage];
  
  swipeButtonImage.translatesAutoresizingMaskIntoConstraints = false;
  [swipeButtonImage.heightAnchor constraintEqualToConstant:4].active = true;
  [swipeButtonImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
  [swipeButtonImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:12].active = true;
}

- (void)setNavBarView {
  self.navBarView = [UIView new];
  titleName = [UILabel new];
  closeButton = [UIButton new];
  
  self.layer.cornerRadius = 24;
  self.layer.maskedCorners = kCALayerMinXMinYCorner;
  self.backgroundColor = [UIColor whiteColor];
  self.layer.masksToBounds = true;
  
  self.navBarView.backgroundColor = [UIColor whiteColor];
  titleName.font = [UIFont fontWithName:@"Circe-Bold" size:20];
  titleName.textAlignment = NSTextAlignmentLeft;
  
  [closeButton setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
  closeButton.contentMode = UIViewContentModeScaleAspectFill;
  closeButton.tintColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:67/255.0 alpha:0.6];
  closeButton.backgroundColor = [UIColor colorWithRed:116/255.0 green:116/255.0 blue:128/255.0 alpha:0.08];
  closeButton.layer.cornerRadius = 15;
  [closeButton addTarget:self
                  action:@selector(closeAction:)
        forControlEvents:UIControlEventTouchUpInside];
  
  [self addSubview: self.navBarView];
  [self.navBarView addSubview:titleName];
  [self.navBarView addSubview:closeButton];
  
  self.navBarView.translatesAutoresizingMaskIntoConstraints = false;
  [self.navBarView.heightAnchor constraintEqualToConstant:44].active = true;
  [self.navBarView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = true;
  [self.navBarView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = true;
  [self.navBarView.topAnchor constraintEqualToAnchor:self.topAnchor constant:20].active = true;
  
  closeButton.translatesAutoresizingMaskIntoConstraints = false;
  [closeButton.heightAnchor constraintEqualToConstant:30].active = true;
  [closeButton.widthAnchor constraintEqualToConstant:30].active = true;
  [closeButton.trailingAnchor constraintEqualToAnchor:self.navBarView.trailingAnchor constant:-24].active = true;
  [closeButton.bottomAnchor constraintEqualToAnchor:self.navBarView.bottomAnchor constant:-16].active = true;
  
  titleName.translatesAutoresizingMaskIntoConstraints = false;
  [titleName.heightAnchor constraintEqualToConstant:30].active = true;
  [titleName.leadingAnchor constraintEqualToAnchor:self.navBarView.leadingAnchor constant:16].active = true;
  [titleName.trailingAnchor constraintEqualToAnchor:closeButton.leadingAnchor constant:8].active = true;
  [titleName.bottomAnchor constraintEqualToAnchor:self.navBarView.bottomAnchor constant:-16].active = true;
}

- (void)setTableView {
  self.tableView = [UITableView new];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.separatorColor = [UIColor clearColor];

  
  UINib *detailNib = [UINib nibWithNibName:NSStringFromClass([DetailViewCell class]) bundle:[NSBundle mainBundle]];
  [self.tableView registerNib:detailNib forCellReuseIdentifier:@"Cell"];
  UINib *scheduleNib = [UINib nibWithNibName:NSStringFromClass([ScheduleViewCell class]) bundle:[NSBundle mainBundle]];
  [self.tableView registerNib:scheduleNib forCellReuseIdentifier:@"ScheduleCell"];
  UINib *imageViewNib = [UINib nibWithNibName:NSStringFromClass([ImageViewCell class]) bundle:[NSBundle mainBundle]];
  [self.tableView registerNib:imageViewNib forCellReuseIdentifier:@"ImageCell"];
  UINib *trashTypeViewNib = [UINib nibWithNibName:NSStringFromClass([TrashTypeCell class]) bundle:[NSBundle mainBundle]];
  [self.tableView registerNib:trashTypeViewNib forCellReuseIdentifier:@"TrashTypeCell"];
  
  [self addSubview:self.tableView];
  self.tableView.translatesAutoresizingMaskIntoConstraints = false;
  [self.tableView.topAnchor constraintEqualToAnchor:self.navBarView.bottomAnchor constant:0].active = true;
  [self.tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = true;
  [self.tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = true;
  [self.tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = true;
}

- (void)closeAction:(UIButton*)sender {
  [self.delegate removeDetailView];
  [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    if (data.photo == nil) {
      return 0;
    }
  } else if (indexPath.row == 2) {
    NSMutableSet *checkEqualTimeFromTo = [[NSMutableSet alloc] init];
    for (SYNSchedule *schedule in data.schedule.allValues) {
      [checkEqualTimeFromTo addObject:[schedule valueForKey:@"from"]];
      [checkEqualTimeFromTo addObject:[schedule valueForKey:@"to"]];
    }
    if (checkEqualTimeFromTo.count == 2 && data.schedule.allValues.count == 7) {
      return 75;
    }
  } else if (indexPath.row == 4) {
    if (data.trashTypes.allValues == nil) {
      return 0;
    } else {
      return 30 + data.trashTypes.allValues.count * 30;
    }
  }
  return UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  static NSString *detailCellIdentifier = @"Cell";
  static NSString *scheduleCellIdentifier = @"ScheduleCell";
  static NSString *imageCellIdentifier = @"ImageCell";
  static NSString *trashTypeCellIdentifier = @"TrashTypeCell";
  UITableViewCell *cell;
  
  if (indexPath.row == 0) {
    ImageViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:data.photo];
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(globalQueue, ^{
      NSData *imgData = [NSData dataWithContentsOfURL:url];
      UIImage *img = [[UIImage alloc] initWithData:imgData];
      UIImage *imgWithCorner = [self imageWithRoundedCornersSize:16 usingImage:img];
      dispatch_async(dispatch_get_main_queue(), ^{
        [imageCell.imageViewPoint setImage:imgWithCorner];
      });
    });
    return imageCell;
    
  } else if (indexPath.row == 1) {
    DetailViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier forIndexPath:indexPath];
    detailCell.detailsLabel.text = [NSString stringWithFormat:@"%@, %@", data.address, data.city.title];
    [detailCell.iconImageView setImage:[UIImage imageNamed:@"location"]];
    NSArray<SYNCategory *> *qat = [data.categories allValues];
    NSSortDescriptor *sortById = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortById];
    NSArray<SYNCategory *>* sortedQat = [qat sortedArrayUsingDescriptors:sortDescriptors];
    detailCell.iconImageView.tintColor = [UIColor colorFromHexString:sortedQat[0].color];
    return detailCell;
    
  } else if (indexPath.row == 2) {
    ScheduleViewCell *scheduleCell = [tableView dequeueReusableCellWithIdentifier:scheduleCellIdentifier forIndexPath:indexPath];
    scheduleCell.workTimeImageView.tintColor = [UIColor colorFromHexString:@"#ABABAB"];
    [scheduleCell setScheduleCell: data.schedule.allValues];
    return scheduleCell;
    
  } else if (indexPath.row == 3) {
    DetailViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier forIndexPath:indexPath];
    detailCell.detailsLabel.text = data.phone;
    detailCell.detailsLabel.textColor = [UIColor colorFromHexString:@"#007AFF"];
    [detailCell.iconImageView setImage:[UIImage imageNamed:@"call"]];
    detailCell.iconImageView.tintColor = [UIColor colorFromHexString:@"#ABABAB"];
    return detailCell;
    
  } else if (indexPath.row == 4) {
    TrashTypeCell *trashTypeCell = [tableView dequeueReusableCellWithIdentifier:trashTypeCellIdentifier forIndexPath:indexPath];
    [trashTypeCell setTrashtype:data.trashTypes.allValues];
    return trashTypeCell;
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 3) {
    NSString *number = [NSString stringWithFormat:@"tel:%@", data.phone];
    NSString *numberWithoutSpace = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberWithoutSpace] options:@{} completionHandler:nil];
  }
}

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original {
  double scale = original.size.height / 184; // 184 is degault image height in figma
  CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);

  UIGraphicsBeginImageContextWithOptions(original.size, NO, 0.0f);
  [[UIBezierPath bezierPathWithRoundedRect:frame
                              cornerRadius:cornerRadius * scale] addClip];
  [original drawInRect:frame];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
