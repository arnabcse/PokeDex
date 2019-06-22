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
#import "ImagesColVWCell.h"
#import "AbilityColVWCell.h"
#import "TypeColVWCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsScreenVC ()

@end

@implementation DetailsScreenVC
@synthesize strPokemonName,strPokemonURL;
@synthesize lblNamePokemon,vwMoves,colVWMoves;
@synthesize vwStats,colVWStats;
@synthesize vwImages,colVWImages;
@synthesize vwAbility,colVWAbility;
@synthesize vwType,colVWType;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colVWMoves.delegate = self;
    self.colVWMoves.dataSource = self;
    self.colVWStats.delegate = self;
    self.colVWStats.dataSource = self;
    self.colVWImages.delegate = self;
    self.colVWImages.dataSource = self;
    self.colVWAbility.delegate = self;
    self.colVWAbility.dataSource = self;
    self.colVWType.delegate = self;
    self.colVWType.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.lblNamePokemon.text = self.strPokemonName;
    m_strURL = self.strPokemonURL;
    [self getData:(NSString *)m_strURL];
    self.vwMoves.layer.cornerRadius = 10;
    self.vwMoves.clipsToBounds = YES;
    self.vwStats.layer.cornerRadius = 10;
    self.vwStats.clipsToBounds = YES;
    self.vwImages.layer.cornerRadius = 10;
    self.vwImages.clipsToBounds = YES;
    self.vwAbility.layer.cornerRadius = 10;
    self.vwAbility.clipsToBounds = YES;
    self.vwType.layer.cornerRadius = 10;
    self.vwType.clipsToBounds = YES;
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
        [m_objStatsDataModel setM_strBaseVal:[[StatsDataSet valueForKey:@"base_stat"] stringValue]];
        [m_objStatsDataModel setM_strEffortVal:[[StatsDataSet valueForKey:@"effort"] stringValue]];
        [m_objStatsDataModel setM_strStatsName:NameInfo];
        [m_arrStatsData addObject:m_objStatsDataModel];
    }
    
    NSArray *resultsImages = [jsonInfoData valueForKey:@"sprites"];
    m_arrImagesData = [NSMutableArray array];
    imageStr1 = [resultsImages valueForKey:@"back_default"];
    imageStr2 = [resultsImages valueForKey:@"back_shiny"];
    imageStr3 = [resultsImages valueForKey:@"front_shiny"];
    imageStr4 = [resultsImages valueForKey:@"front_default"];
    [m_arrImagesData addObject:imageStr1];
    [m_arrImagesData addObject:imageStr2];
    [m_arrImagesData addObject:imageStr3];
    [m_arrImagesData addObject:imageStr4];
    
    NSArray *resultsAbility = [jsonInfoData valueForKey:@"abilities"];
    m_arrAbilityData = [NSMutableArray array];
    for (NSDictionary *AbilityDataSet in resultsAbility){
        m_objAbilityDataModel = [[AbilityDataModel alloc]init];
        NSString *NameInfo = [[AbilityDataSet valueForKey:@"ability"] valueForKey:@"name"];
        if([[AbilityDataSet valueForKey:@"is_hidden"] boolValue]){
            [m_objAbilityDataModel setM_strisHidden:@"true"];
        }else{
            [m_objAbilityDataModel setM_strisHidden:@"false"];
        }
        [m_objAbilityDataModel setM_strSlot:[[AbilityDataSet valueForKey:@"slot"] stringValue]];
        [m_objAbilityDataModel setM_strAbilityName:NameInfo];
        [m_arrAbilityData addObject:m_objAbilityDataModel];
    }
    
    NSArray *resultsType = [jsonInfoData valueForKey:@"types"];
    NSString * speciesName = [[jsonInfoData valueForKey:@"species"] valueForKey:@"name"];
    m_arrTypeData = [NSMutableArray array];
    for (NSDictionary *TypeDataSet in resultsType){
        m_objTypeDataModel = [[TypeDataModel alloc]init];
        NSString *NameInfo = [[TypeDataSet valueForKey:@"type"] valueForKey:@"name"];
        [m_objTypeDataModel setM_strSlot:[[TypeDataSet valueForKey:@"slot"] stringValue]];
        [m_objTypeDataModel setM_strSpecies:speciesName];
        [m_objTypeDataModel setM_strTypeName:NameInfo];
        [m_arrTypeData addObject:m_objTypeDataModel];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.colVWMoves){
        return m_arrMovesData.count;
    }
    else if(collectionView == self.colVWStats){
        return m_arrStatsData.count;
    }else if(collectionView == self.colVWAbility){
        return m_arrAbilityData.count;
    }else if(collectionView == self.colVWType){
        return m_arrTypeData.count;
    }else{
        return 4;
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
    }else if(collectionView == self.colVWAbility){
        AbilityColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AbilityColCell" forIndexPath:indexPath];
        [cell.lblSlot setText:[[m_arrAbilityData objectAtIndex:indexPath.row]m_strSlot]];
        [cell.lblHidden setText:[[m_arrAbilityData objectAtIndex:indexPath.row]m_strisHidden]];
        [cell.lblNameAbility setText:[[m_arrAbilityData objectAtIndex:indexPath.row]m_strAbilityName]];
        return cell;
    }else if(collectionView == self.colVWType){
        TypeColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colTypeCell" forIndexPath:indexPath];
        [cell.lblSlotValue setText:[[m_arrTypeData objectAtIndex:indexPath.row]m_strSlot]];
        [cell.lblSpecies setText:[[m_arrTypeData objectAtIndex:indexPath.row]m_strSpecies]];
        [cell.lblTypeName setText:[[m_arrTypeData objectAtIndex:indexPath.row]m_strTypeName]];
        return cell;
    }else{
        ImagesColVWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagesColCell" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[m_arrImagesData objectAtIndex:indexPath.row]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        cell.image.image = img;
        return cell;
    }
    
}


@end
