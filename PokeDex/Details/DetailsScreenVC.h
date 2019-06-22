//
//  DetailsScreenVC.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovesDataModel.h"
#import "StatsDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsScreenVC : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString * m_strURL;
    NSMutableArray * m_arrMovesData;
    MovesDataModel *m_objMoveDataModel;
    NSInteger movesCounter;
    NSMutableArray * m_arrStatsData;
    StatsDataModel *m_objStatsDataModel;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNamePokemon;
@property (weak, nonatomic) IBOutlet UIView *vwMoves;

@property (weak, nonatomic) IBOutlet UICollectionView *colVWMoves;
@property (weak, nonatomic) IBOutlet UIView *vwStats;

@property (weak, nonatomic) IBOutlet UICollectionView *colVWStats;


@property (nonatomic, strong) NSString *strPokemonName;
@property (nonatomic, strong) NSString *strPokemonURL;

@end

NS_ASSUME_NONNULL_END
