//
//  PokeMonListModel.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokeMonListModel : NSObject

@property (nonatomic, retain) NSString *m_strURL;
@property (nonatomic, retain) NSString *m_strImage;
@property (nonatomic, retain) NSString *m_strName;
@property (nonatomic, retain) NSString *m_strId;
@property (nonatomic, retain) NSString *m_strOrder;
@property (nonatomic, retain) NSString *m_strHeight;
@property (nonatomic, retain) NSString *m_strWeight;
@property (nonatomic, retain) NSString *m_strBaseExperience;


@end

NS_ASSUME_NONNULL_END
