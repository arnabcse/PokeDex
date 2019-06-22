//
//  TypeDataModel.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeDataModel : NSObject

@property (nonatomic, retain) NSString *m_strTypeName;
@property (nonatomic, retain) NSString *m_strSlot;
@property (nonatomic, retain) NSString *m_strSpecies;

@end

NS_ASSUME_NONNULL_END
