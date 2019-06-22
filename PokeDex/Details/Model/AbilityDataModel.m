//
//  AbilityDataModel.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "AbilityDataModel.h"

@implementation AbilityDataModel
@synthesize m_strAbilityName,m_strisHidden,m_strSlot;
- (id)init
{
    self=[super init];
    if(self){
        
        self.m_strAbilityName = @"";
        self.m_strisHidden = @"";
        self.m_strSlot = @"";
    }
    
    return self;
}

@end
