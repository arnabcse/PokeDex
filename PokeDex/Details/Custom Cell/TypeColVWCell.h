//
//  TypeColVWCell.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeColVWCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTypeName;
@property (weak, nonatomic) IBOutlet UILabel *lblSlotValue;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecies;


@end

NS_ASSUME_NONNULL_END
