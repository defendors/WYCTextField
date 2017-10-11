//
//  WYCTextField.h
//  WYCTextField
//
//  Created by WD_王宇超 on 2017/10/11.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,autoInsertSpaceMode){
	autoInsertSpaceMode_cellphone,//国内手机号的分隔方式(从后向前，每4位插入分隔空格符)
	autoInsertSpaceMode_backcardNumber,//银行卡号分隔(从前往后每四位插入分隔空格)
	autoInsertSpaceMode_other
};
@interface WYCTextField : UITextField
/*
 textField左右分别会有两个view。每个view会有个label。
 所有的size，最终都会取相应的最大值maxHeight和maxWidth
 */

@property(assign,nonatomic)CGSize leftViewSize;
@property(assign,nonatomic)CGSize rightViewSize;

@property(strong,nonatomic)UILabel* leftTitleLabel;
@property(assign,nonatomic)CGSize leftTitleLabelSize;

@property(strong,nonatomic)UILabel* rightTitleLabel;
@property(assign,nonatomic)CGSize rightTitleLabelSize;

@property(strong,nonatomic)UIImageView* leftImageView;
@property(assign,nonatomic)CGSize leftImageViewSize;

@property(strong,nonatomic)UIImageView* rightImageView;
@property(assign,nonatomic)CGSize rightImageViewSize;

@property(strong,nonatomic)UIButton* rightButton;
/**
 文字或图片(leftTitleLabel或leftImageView) 距离左边的距离
 */
@property(assign,nonatomic)CGFloat leftSpace;
/**
 文字或图片(rightTitleLabel或rightImageView) 距离右边的距离
 */
@property(assign,nonatomic)CGFloat rightSpace;
/**
 标题或图片(leftTitleLabel或leftImageView) 距离输入文字的距离
 */
@property(assign,nonatomic)CGFloat centerSpace;


/**
 边框的有色垂线高度所占view高度的比例。
 */
@property(assign,nonatomic)float verticalLinePercent;
/**
 有色垂线的颜色。底部有色水平线不能设置高度。当颜色为nil时，垂线消失
 */
@property(strong,nonatomic)UIColor* lineColor;
/**
 线的宽度。默认为1
 */
@property(assign,nonatomic)CGFloat lineWidth;

/**
 在UITextFieldTextDidChangeNotification通知事件中调用后，才能开启插入空格功能。如不实现，无法开始插入空格功能
 
 @param notification 通知
 */
- (void)textFieldTextDidChangeNotification:(NSNotification*)notification;
#pragma mark 插入空格的相关属性
/**
 插入空格模式
 */
@property(assign,nonatomic)BOOL isAllowAutoInsertSpace;
/**
 插入空格模式
 */
@property(assign,nonatomic)autoInsertSpaceMode textAutoInsertSpaceMode;
/**
 输入的最大字符串长度(手机号模式下无效，默认为23位)
 */
@property(assign,nonatomic)NSInteger maxLength;
/**
 插入空格所在的位置
 */
/**
 空格所在位置(下角标)，元素为NSNumber对象。(必须为非负整数)
 */
@property(strong,nonatomic)NSSet<NSNumber*>* spaceIndexes;

@end



