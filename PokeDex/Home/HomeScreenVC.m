//
//  HomeScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//


#import "HomeScreenVC.h"
#import "PokeMonListCell.h"


@interface HomeScreenVC ()

@end

@implementation HomeScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.actIndicatorVw startAnimating];
    self.tblVwPokemonList.delegate = self;
    self.tblVwPokemonList.dataSource = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self fetchData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.actIndicatorVw stopAnimating];
            [self.tblVwPokemonList reloadData];
        });
    });
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

}

- (void)fetchData{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://pokeapi.co/api/v2/pokemon/"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *results = [json valueForKey:@"results"];
    m_arrListInfo = [NSMutableArray array];
    for (NSDictionary *urlList in results){
        NSString *url_stringInfo = [urlList valueForKey:@"url"];
        NSData *dataInfo = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_stringInfo]];
        NSMutableArray *jsonInfoData = [NSJSONSerialization JSONObjectWithData:dataInfo options:kNilOptions error:&error];
        NSLog(@"jsonInfoData: %@", jsonInfoData);
        NSArray *images = [jsonInfoData valueForKey:@"sprites"];
        NSString *stringImage = @"";
        stringImage = [images valueForKey:@"front_shiny"];
        m_objPokeMonListModel = [[PokeMonListModel alloc]init];
        [m_objPokeMonListModel setM_strImage:stringImage];
        [m_objPokeMonListModel setM_strName:[jsonInfoData valueForKey:@"name"]];
        [m_objPokeMonListModel setM_strId:[[jsonInfoData valueForKey:@"id"] stringValue]];
        [m_objPokeMonListModel setM_strOrder:[[jsonInfoData valueForKey:@"order"] stringValue]];
        [m_objPokeMonListModel setM_strHeight:[[jsonInfoData valueForKey:@"height"] stringValue]];
        [m_objPokeMonListModel setM_strWeight:[[jsonInfoData valueForKey:@"weight"] stringValue]];
        [m_objPokeMonListModel setM_strBaseExperience:[[jsonInfoData valueForKey:@"base_experience"] stringValue]];
        [m_arrListInfo addObject:m_objPokeMonListModel];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrListInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellPokemonList";
    PokeMonListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.lblPokemonName.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strName];
    cell.lblPokemonOrder.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strOrder];
    cell.lblPokemonId.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strId];
    cell.lblPokemonHeight.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strHeight];
    cell.lblPokemonWeight.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strWeight];
    cell.lblPokemonBaseExp.text = [[m_arrListInfo objectAtIndex:indexPath.row]m_strBaseExperience];
    NSURL *url = [NSURL URLWithString:[[m_arrListInfo objectAtIndex:indexPath.row]m_strImage]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    cell.imgVWPokemoNImg.image = img;
    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.layer.borderWidth = 10;
    cell.layer.borderColor = [cell backgroundColor].CGColor;
    return cell;
}


@end
