//
//  MovesDataModel.m
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "MovesDataModel.h"

@implementation MovesDataModel
@synthesize m_strLevelNo,m_strMoveName;

- (id)init
{
    self=[super init];
    if(self){
        
        self.m_strLevelNo = @"";
        self.m_strMoveName = @"";
    }
    
    return self;
}


@end
