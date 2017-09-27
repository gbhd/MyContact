//
//  ViewController.m
//  MyContact
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MyContactTableViewCellA.h"
#import "MyContactTableViewCellB.h"
#import "MyContactCollectionViewCell.h"
#define selectBtn_tag 100

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    BOOL isSelected;
}

@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *selectAry;

@property(strong,nonatomic)UICollectionView *homeCollectionV;
@property(strong,nonatomic)UICollectionViewFlowLayout *homeFlowL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubViews];
}

-(void)setSubViews{
    
    _selectAry = [NSMutableArray new];
    
    for (int i = 0; i < 6; i++) {
        [_selectAry addObject:@"0"];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 300;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    
    
    _homeFlowL = [UICollectionViewFlowLayout new];
    [_homeFlowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    _homeCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kNavBarHeight) collectionViewLayout:_homeFlowL];
    _homeCollectionV.delegate = self;
    _homeCollectionV.dataSource = self;
    _homeCollectionV.backgroundColor = [UIColor clearColor];
    _homeCollectionV.hidden = YES;
    [self.view addSubview:_homeCollectionV];
    
//    [_homeCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    [_homeCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
     [_homeCollectionV registerNib:[UINib nibWithNibName:[MyContactCollectionViewCell.class description] bundle:nil] forCellWithReuseIdentifier:@"MyContactCollectionViewCell"];
}

#pragma mark --UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _selectAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_selectAry[section] integerValue] == 0) {
        return 1;
    }else{
        return 6;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectAry[indexPath.section] integerValue] == 0) {
        static NSString *DetailsImg = @"DetailsImg";
        MyContactTableViewCellA *cell = [tableView dequeueReusableCellWithIdentifier:DetailsImg];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyContactTableViewCellA" owner:self options:nil]lastObject];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else{
        static NSString *PaymentDetails = @"PaymentDetails";
        MyContactTableViewCellB *cell = [tableView dequeueReusableCellWithIdentifier:PaymentDetails];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyContactTableViewCellB" owner:self options:nil]lastObject];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *header =[UILabel new];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    header.frame = CGRectMake(0, 0, kScreenWidth, 50);
    header.text = [NSString stringWithFormat:@"第%zi组",section];
    header.textAlignment = NSTextAlignmentCenter;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    footView.backgroundColor = [UIColor whiteColor];

    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor = [UIColor whiteColor];
    selectBtn.tag = section + selectBtn_tag;
    selectBtn.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [selectBtn setTitle:@"展开" forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectMothed:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, 0)];


    if ([_selectAry[section] integerValue] == 0) {
        [selectBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        [selectBtn setTitle:@"展开" forState:UIControlStateNormal];
    }else{
        [selectBtn setImage:[UIImage imageNamed:@"uplist"] forState:UIControlStateNormal];
        [selectBtn setTitle:@"折叠" forState:UIControlStateNormal];
    }
    [footView addSubview:selectBtn];

    return footView;
}

-(void)selectMothed:(UIButton *)btn{
    
    if ([_selectAry[btn.tag - selectBtn_tag] integerValue] == 0) {
        
        [_selectAry replaceObjectAtIndex:btn.tag - selectBtn_tag withObject:@"1"];
        
    }else{
        [_selectAry replaceObjectAtIndex:btn.tag - selectBtn_tag withObject:@"0"];
    }
    
    [_tableView reloadData];
}
- (IBAction)SelectedToggle:(UIBarButtonItem *)sender {
    if (!isSelected) {
        _tableView.hidden = YES;
        _homeCollectionV.hidden = NO;
        isSelected = YES;
        [_homeCollectionV reloadData];
    }else{
        _tableView.hidden = NO;
        _homeCollectionV.hidden = YES;
        isSelected = NO;
        [_tableView reloadData];
    }
}


#pragma mark --UICollectionView dataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _selectAry.count;
}

//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyContactCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 4)/3, 220);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//        return CGSizeMake(kScreenWidth,50);
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
        return CGSizeMake(kScreenWidth,50);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
//    if (kind == UICollectionElementKindSectionHeader) {
//        UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//
//        return reusableView;
//    }else
    if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        
        UILabel *header =[UILabel new];
        header.backgroundColor = [UIColor groupTableViewBackgroundColor];
        header.frame = CGRectMake(0, 0, kScreenWidth, 50);
        header.text = [NSString stringWithFormat:@"第%zi组",indexPath.section];
        header.textAlignment = NSTextAlignmentCenter;
        [reusableView addSubview:header];
        return reusableView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
