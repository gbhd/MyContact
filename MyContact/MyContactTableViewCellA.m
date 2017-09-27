//
//  MyContactTableViewCellA.m
//  MyContact
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyContactTableViewCellA.h"

@implementation MyContactTableViewCellA
-(void)setPaymentDetailsImg:(NSMutableArray *)ary indexPath:(NSIndexPath *)indexPath{
    
    _numLab.text = [NSString stringWithFormat:@"共%zi个商品",ary.count];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
