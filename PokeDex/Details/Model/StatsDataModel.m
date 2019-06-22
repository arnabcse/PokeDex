//
//  StatsDataModel.m
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "StatsDataModel.h"

@implementation StatsDataModel
@synthesize m_strStatsName,m_strBaseVal,m_strEffortVal;

- (id)init
{
    self=[super init];
    if(self){
        
        self.m_strStatsName = @"";
        self.m_strBaseVal = @"";
        self.m_strEffortVal = @"";
    }
    
    return self;
}
@end
