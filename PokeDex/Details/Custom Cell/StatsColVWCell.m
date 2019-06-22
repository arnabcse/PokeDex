//
//  StatsColVWCell.m
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "StatsColVWCell.h"

@implementation StatsColVWCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.clipsToBounds = YES;
}

@end
