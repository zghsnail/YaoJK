//
//  DatePickerView.h
//  库存管理
//
//  Created by liuyang on 2017/7/12.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

/** rgb颜色转换（16进制->10进制）*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <UIKit/UIKit.h>
typedef enum{
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd = 1,
    
}DateType;

@protocol DatePickerViewDelegate <NSObject>

- (void)getSelectDate:(NSString *)date type:(DateType)type;

@end

@interface DatePickerView : UIView
@property(nonatomic,strong)UIDatePicker * datePickerView;
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)UIButton * cannelBtn;
@property(nonatomic,assign)BOOL isDatePiker;

@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateType type;

- (void)setDataWithTime:(BOOL)time;

+(id)datePickerView;
@end
