//
//  DetailsScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "DetailsScreenVC.h"
#import "MovesColVWCell.h"
#import "StatsColVWCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsScreenVC ()

@end

@implementation DetailsScreenVC
@synthesize strPokemonName,strPokemonURL;
@synthesize lblNamePokemon,vwMoves,colVWMoves;
@synthesize vwStats,colVWStats;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colVWMoves.delegate = self;
    self.colVWMoves.dataSource = self;
    self.colVWStats.delegate = self;
    self.colVWStats.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.lblNamePokemon.text = self.strPokemonName;
    m_strURL = self.strPokemonURL;
    [self getData:(NSString *)m_strURL];
    self.vwMoves.layer.cornerRadius = 10;
    self.vwMoves.clipsToBounds = YES;
    self.vwStats.layer.cornerRadius = 10;
    self.vwStats.clipsToBounds = YES;
}

- (void)getData:(NSString *)stringUrl{
    NSError *error;
    NSData *dataInfo = [NSData dataWithContentsOfURL: [NSURL URLWithString:stringUrl]];
    NSMutableArray *jsonInfoData = [NSJSONSerialization JSONObjectWithData:dataInfo options:kNilOptions error:&error];
    NSLog(@"jsonInfoData: %@", jsonInfoData);
    NSArray *resultsMoves = [jsonInfoData valueForKey:@"moves"];
    m_arrMovesData = [NSMutableArray array];
    movesCounter = 0;
    for (NSDictionary *MoveDataSet in resultsMoves){
        m_objMoveDataModel = [[MovesDataModel alloc]init];
        NSString *NameInfo = [[MoveDataSet valueForKey:@"move"] valueForKey:@"name"];
        [m_objMoveDataModel setM_strLevelNo:[@(movesCounter) stringValue]];
        [m_objMoveDataModel setM_strMoveName:NameInfo];
        [m_arrMovesData addObject:m_objMoveDataModel];
    }
    NSArray *resultsStats = [jsonInfoData valueForKey:@"stats"];
    m_arrStatsData = [NSMutableArray array];
    for (NSDictionary *StatsDataSet in resultsStats){
        m_objStatsDataModel = [[StatsDataModel alloc]init];
        NSString *NameInfo = [[StatsDataSet valueForKey:@"stat"] valueForKey:@"name"];
        [m_objStatsDataModel setM_strBaseVal:[StatsDataSet valueForKey:@"base_stat"]];
        [m_objStatsDataModel setM_strEffortVal:[StatsDataSet valueForKey:@"effort"]];
        [m_objStatsDataModel setM_strStatsName:NameInfo];
        [m_arrStatsData addObject:m_objStatsDataModel];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.colVWMoves){
        return m_arrMovesData.count;
    }
    else if(collectionView == self.colVWStats){
        return m_arrStatsData.count;
    }else{
        return m_arrStatsData.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.colVWMoves){
        MovesColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovesColCell" forIndexPath:indexPath];
        [cell.lblLevel setText:[[m_arrMovesData objectAtIndex:indexPath.row]m_strLevelNo]];
        [cell.lblMovesName setText:[[m_arrMovesData objectAtIndex:indexPath.row]m_strMoveName]];
        return cell;
    }
    else if(collectionView == self.colVWStats){
        StatsColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StatsColCell" forIndexPath:indexPath];
        [cell.lblBaseVal setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strBaseVal]];
        [cell.lblEffVal setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strEffortVal]];
        [cell.lblStatsName setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strStatsName]];
        return cell;
    }else{
        StatsColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StatsColCell" forIndexPath:indexPath];
        [cell.lblBaseVal setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strBaseVal]];
        [cell.lblEffVal setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strEffortVal]];
        [cell.lblStatsName setText:[[m_arrStatsData objectAtIndex:indexPath.row]m_strStatsName]];
        return cell;
    }
    
}


@end
