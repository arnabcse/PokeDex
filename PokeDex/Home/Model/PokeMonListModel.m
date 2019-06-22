//
//  PokeMonListModel.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "PokeMonListModel.h"

@implementation PokeMonListModel
@synthesize m_strImage,m_strName,m_strId,m_strOrder,m_strHeight,m_strWeight,m_strBaseExperience,m_strURL;


- (id)init
{
    self=[super init];
    if(self){
        
        self.m_strImage = @"";
        self.m_strName = @"";
        self.m_strId = @"";
        self.m_strOrder = @"";
        self.m_strHeight = @"";
        self.m_strWeight = @"";
        self.m_strBaseExperience = @"";
        self.m_strURL = @"";
        
    }
    
    return self;
}


@end
