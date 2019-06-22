//
//  TypeColVWCell.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "TypeColVWCell.h"

@implementation TypeColVWCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.clipsToBounds = YES;
}

@end
