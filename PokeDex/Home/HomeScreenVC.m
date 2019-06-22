//
//  HomeScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//


#import "HomeScreenVC.h"
#import "PokeMonListCell.h"
#import "DetailsScreenVC.h"

@interface HomeScreenVC ()

@end

@implementation HomeScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtFldSearch.delegate = self;
    searchStr = @"";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.menuVW setAlpha:0.5];
    [self.menuVW setUserInteractionEnabled:NO];
    [self.actIndicatorVw startAnimating];
    self.tblVwPokemonList.delegate = self;
    self.tblVwPokemonList.dataSource = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self fetchData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.actIndicatorVw stopAnimating];
            [self.tblVwPokemonList reloadData];
            [self.menuVW setAlpha:1];
            [self.menuVW setUserInteractionEnabled:YES];
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
        [m_objPokeMonListModel setM_strURL:url_stringInfo];
        [m_objPokeMonListModel setM_strImage:stringImage];
        [m_objPokeMonListModel setM_strName:[jsonInfoData valueForKey:@"name"]];
        [m_objPokeMonListModel setM_strId:[[jsonInfoData valueForKey:@"id"] stringValue]];
        [m_objPokeMonListModel setM_strOrder:[[jsonInfoData valueForKey:@"order"] stringValue]];
        [m_objPokeMonListModel setM_strHeight:[[jsonInfoData valueForKey:@"height"] stringValue]];
        [m_objPokeMonListModel setM_strWeight:[[jsonInfoData valueForKey:@"weight"] stringValue]];
        [m_objPokeMonListModel setM_strBaseExperience:[[jsonInfoData valueForKey:@"base_experience"] stringValue]];
        [m_arrListInfo addObject:m_objPokeMonListModel];
        searchArray = [NSMutableArray arrayWithArray:m_arrListInfo];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellPokemonList";
    PokeMonListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.lblPokemonName.text = [[searchArray objectAtIndex:indexPath.row]m_strName];
    cell.lblPokemonOrder.text = [[searchArray objectAtIndex:indexPath.row]m_strOrder];
    cell.lblPokemonId.text = [[searchArray objectAtIndex:indexPath.row]m_strId];
    cell.lblPokemonHeight.text = [[searchArray objectAtIndex:indexPath.row]m_strHeight];
    cell.lblPokemonWeight.text = [[searchArray objectAtIndex:indexPath.row]m_strWeight];
    cell.lblPokemonBaseExp.text = [[searchArray objectAtIndex:indexPath.row]m_strBaseExperience];
    NSURL *url = [NSURL URLWithString:[[searchArray objectAtIndex:indexPath.row]m_strImage]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    cell.imgVWPokemoNImg.image = img;
    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.layer.borderWidth = 10;
    cell.layer.borderColor = [cell backgroundColor].CGColor;
    return cell;
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    self.txtFldSearch.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    self.txtFldSearch.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@""]){
        searchStr = @"";
        searchArray = [NSMutableArray arrayWithArray:m_arrListInfo];
        [self.tblVwPokemonList reloadData];
    }else{
        NSString *searchTerm = [searchStr stringByAppendingString:string];
        searchStr = searchTerm;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(m_strName CONTAINS[cd] %@) OR (m_strId = %@) OR (m_strOrder = %@)",searchTerm,string,string];
        searchArray =[NSMutableArray arrayWithArray:[m_arrListInfo filteredArrayUsingPredicate:predicate]];
        NSLog(@"search array is:%@",searchArray);
        [self.tblVwPokemonList reloadData];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    searchStr = @"";
    searchArray = [NSMutableArray arrayWithArray:m_arrListInfo];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) btnFilterTapped:(id) sender{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle: UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Highest Order" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strOrder"
                                                                           ascending:NO
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Lowest Order" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strOrder"
                                                                           ascending:YES
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Most Base Experience" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strBaseExperience"
                                                                           ascending:NO
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Least Base Experience" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor =  [NSSortDescriptor sortDescriptorWithKey:@"m_strBaseExperience"
                                                                            ascending:YES
                                                                           comparator:^(id obj1, id obj2){
                                                                               return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                       options:NSNumericSearch];
                                                                           }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Highest Weight" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strWeight"
                                                                           ascending:NO
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Lowest Weight" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strWeight"
                                                                           ascending:YES
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Highest Height" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strHeight"
                                                                           ascending:NO
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Lowest Height" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSSortDescriptor * brandDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_strHeight"
                                                                           ascending:YES
                                                                          comparator:^(id obj1, id obj2){
                                                                              return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                      options:NSNumericSearch];
                                                                          }];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [self->searchArray sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"sortedArray %@",sortedArray);
        self->searchArray = [NSMutableArray arrayWithArray:sortedArray];
        [self.tblVwPokemonList reloadData];
    }]];
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController * popover = alertController.popoverPresentationController;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popover.sourceView = sender;
    
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"details"]) {
        NSIndexPath *indexPath = [self.tblVwPokemonList indexPathForSelectedRow];
        DetailsScreenVC *destViewController = segue.destinationViewController;
        destViewController.strPokemonName = [[searchArray objectAtIndex:indexPath.row]m_strName];
        destViewController.strPokemonURL = [[searchArray objectAtIndex:indexPath.row]m_strURL];
    }
}


@end
