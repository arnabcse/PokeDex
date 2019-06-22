//
//  TypeDataModel.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "TypeDataModel.h"

@implementation TypeDataModel
@synthesize m_strTypeName,m_strSlot,m_strSpecies;

- (id)init
{
    self=[super init];
    if(self){
        
        self.m_strTypeName = @"";
        self.m_strSlot = @"";
        self.m_strSpecies = @"";
    }
    
    return self;
}

@end
