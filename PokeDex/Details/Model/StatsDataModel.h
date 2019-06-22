//
//  StatsDataModel.h
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatsDataModel : NSObject

@property (nonatomic, retain) NSString *m_strStatsName;
@property (nonatomic, retain) NSString *m_strBaseVal;
@property (nonatomic, retain) NSString *m_strEffortVal;

@end

NS_ASSUME_NONNULL_END
