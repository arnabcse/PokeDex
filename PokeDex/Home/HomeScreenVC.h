//
//  HomeScreenVC.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokeMonListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeScreenVC : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    PokeMonListModel *m_objPokeMonListModel;
    NSMutableArray *m_arrListInfo;
    NSMutableArray *searchArray;
    NSString *searchStr;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFldSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UITableView *tblVwPokemonList;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actIndicatorVw;
@property (weak, nonatomic) IBOutlet UIView *menuVW;


@end

NS_ASSUME_NONNULL_END
