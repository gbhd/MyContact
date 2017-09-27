//
//  MyContactTableViewCellA.h
//  MyContact
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyContactTableViewCellA : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLab;

-(void)setPaymentDetailsImg:(NSMutableArray *)ary indexPath:(NSIndexPath *)indexPath;
@end
