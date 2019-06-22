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
#import "AbilityDataModel.h"
#import "TypeDataModel.h"

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
    NSString * imageStr1;
    NSString * imageStr2;
    NSString * imageStr3;
    NSString * imageStr4;
    NSMutableArray * m_arrImagesData;
    NSMutableArray * m_arrAbilityData;
    AbilityDataModel *m_objAbilityDataModel;
    NSMutableArray * m_arrTypeData;
    TypeDataModel *m_objTypeDataModel;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNamePokemon;
@property (weak, nonatomic) IBOutlet UIView *vwMoves;

@property (weak, nonatomic) IBOutlet UICollectionView *colVWMoves;
@property (weak, nonatomic) IBOutlet UIView *vwStats;

@property (weak, nonatomic) IBOutlet UICollectionView *colVWStats;

@property (weak, nonatomic) IBOutlet UIView *vwImages;
@property (weak, nonatomic) IBOutlet UICollectionView *colVWImages;

@property (weak, nonatomic) IBOutlet UIView *vwAbility;
@property (weak, nonatomic) IBOutlet UICollectionView *colVWAbility;

@property (weak, nonatomic) IBOutlet UIView *vwType;
@property (weak, nonatomic) IBOutlet UICollectionView *colVWType;


@property (nonatomic, strong) NSString *strPokemonName;
@property (nonatomic, strong) NSString *strPokemonURL;

@end

NS_ASSUME_NONNULL_END
