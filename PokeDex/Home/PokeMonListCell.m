//
//  PokeMonListCell.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "PokeMonListCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation PokeMonListCell
@synthesize vwCellContent;
- (void)awakeFromNib {
    [super awakeFromNib];
    self.vwCellContent.layer.cornerRadius = 10;
    self.vwCellContent.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
