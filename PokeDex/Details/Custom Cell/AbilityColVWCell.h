//
//  AbilityColVWCell.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbilityColVWCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNameAbility;
@property (weak, nonatomic) IBOutlet UILabel *lblSlot;
@property (weak, nonatomic) IBOutlet UILabel *lblHidden;


@end

NS_ASSUME_NONNULL_END
