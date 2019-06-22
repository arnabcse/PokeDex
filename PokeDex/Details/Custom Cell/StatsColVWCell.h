//
//  StatsColVWCell.h
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatsColVWCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStatsName;
@property (weak, nonatomic) IBOutlet UILabel *lblBaseVal;
@property (weak, nonatomic) IBOutlet UILabel *lblEffVal;


@end

NS_ASSUME_NONNULL_END
