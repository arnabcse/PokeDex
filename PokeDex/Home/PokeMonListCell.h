//
//  PokeMonListCell.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokeMonListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwCellContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgVWPokemoNImg;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonName;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonId;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonBaseExp;

@end

NS_ASSUME_NONNULL_END
