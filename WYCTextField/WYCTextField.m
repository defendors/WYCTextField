//
//  WYCTextField.m
//  WYCTextField
//
//  Created by WD_王宇超 on 2017/10/11.
//

#import "WYCTextField.h"

@implementation WYCTextField

{
	UIView* leftConstraintView;
	UIView* rightConstraintView;
	UIView* leftVerticalLine;
	UIView* rightVerticalLine;
	UIView* bottomHorizonLine;
	
	CGFloat rightLabelHeight;
	CGFloat leftLabelHeight;
}
@synthesize leftTitleLabel = _leftTitleLabel;
@synthesize rightTitleLabel = _rightTitleLabel;
@synthesize textAutoInsertSpaceMode = _textAutoInsertSpaceMode;
#pragma mark life cycle
-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		
		leftConstraintView = [UIView new];
		_leftImageView = [[UIImageView alloc]init];
		[_leftImageView setContentMode:UIViewContentModeScaleAspectFit];
		_leftTitleLabel = [[UILabel alloc]init];
		self.leftView = leftConstraintView;
		[self setLeftViewMode:UITextFieldViewModeAlways];
		[leftConstraintView addSubview:_leftImageView];
		[leftConstraintView addSubview:_leftTitleLabel];
		
		rightConstraintView = [UIView new];
		_rightImageView = [[UIImageView alloc]init];
		[_rightImageView setContentMode:UIViewContentModeScaleAspectFit];
		_rightTitleLabel = [[UILabel alloc]init];
		self.rightView = rightConstraintView;
		[self setRightViewMode:UITextFieldViewModeAlways];
		[rightConstraintView addSubview:_rightImageView];
		[rightConstraintView addSubview:_rightTitleLabel];
		
		leftVerticalLine = [UIView new];
		[self addSubview:leftVerticalLine];
		rightVerticalLine = [UIView new];
		[self addSubview:rightVerticalLine];
		bottomHorizonLine = [UIView new];
		[self addSubview:bottomHorizonLine];
		
		rightLabelHeight = [self labelHeight:_rightTitleLabel];
		leftLabelHeight = [self labelHeight:_leftTitleLabel];
		
		//开发设置
		_maxLength  = 50;
		
		
	}
	return self;
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat leftView_W = MAX(_leftViewSize.width, MAX(_leftImageViewSize.width, _leftTitleLabelSize.width));
	CGFloat leftView_H = MAX(_leftViewSize.height, MAX(_leftImageViewSize.width, _leftTitleLabelSize.width));
	CGPoint leftView_Center = CGPointMake(0 + _leftSpace + 0.5 * leftView_W, 0.5 * self.frame.size.height);
	[leftConstraintView setFrame:CGRectMake(0, 0, leftView_W + _leftSpace + _centerSpace, leftView_H)];
	
	[_leftImageView setFrame:CGRectMake(0, 0, _leftImageViewSize.width, _leftImageViewSize.height)];
	[_leftImageView setCenter:leftView_Center];
	
	[_leftTitleLabel setFrame:CGRectMake(0, 0, _leftTitleLabelSize.width, leftLabelHeight)];
	[_leftTitleLabel setCenter:leftView_Center];
	
	
	CGFloat rightView_W = MAX(_rightViewSize.width, MAX(_rightImageViewSize.width, _rightTitleLabelSize.width));
	CGFloat rightView_H = MAX(_rightViewSize.height, MAX(_rightImageViewSize.height, _rightTitleLabelSize.height));
	CGPoint rightView_center = CGPointMake(self.frame.size.width - 0.5 * _rightSpace - 0.5 * rightView_W, 0.5 * self.frame.size.height);
	[rightConstraintView setFrame:CGRectMake(0, 0, rightView_W + _rightSpace, rightView_H)];
	[rightConstraintView setCenter:rightView_center];
	
	[_rightImageView setFrame:CGRectMake(0, 0, _rightImageViewSize.width, _rightImageViewSize.height)];
	[_rightImageView setCenter:rightView_center];
	
	[_rightTitleLabel setFrame:CGRectMake(0, 0, _rightTitleLabelSize.width, rightLabelHeight)];
	[_rightTitleLabel setCenter:rightView_center];
	if (_rightButton) {
		[rightConstraintView addSubview:_rightButton];
		[_rightButton setFrame:CGRectMake(0, 0, rightView_W, rightView_H)];
		//		[_rightButton setCenter:rightView_center];
	}
	
	
	if (_lineColor) {
		
		bottomHorizonLine.frame = CGRectMake(0, self.frame.size.height - _lineWidth, self.frame.size.width, _lineWidth);
		leftVerticalLine.frame = CGRectMake(0, self.frame.size.height * _verticalLinePercent, _lineWidth, self.frame.size.height * (1 - _verticalLinePercent));
		rightVerticalLine.frame = CGRectMake(self.frame.size.width - _lineWidth, self.frame.size.height * _verticalLinePercent, _lineWidth, self.frame.size.height * (1 - _verticalLinePercent));
		
		bottomHorizonLine.backgroundColor = _lineColor;
		leftVerticalLine.backgroundColor = _lineColor;
		rightVerticalLine.backgroundColor = _lineColor;
	}
}
#pragma get and set method
- (void)setRightTitleLabel:(UILabel *)rightTitleLabel{
	_rightTitleLabel = rightTitleLabel;
}
- (UILabel*)rightTitleLabel{
	return _rightTitleLabel;
}
- (void)setLeftTitleLabel:(UILabel *)leftTitleLabel{
	_leftTitleLabel = leftTitleLabel;
	
}
- (UILabel*)leftTitleLabel{
	return _leftTitleLabel;
}
- (void)setTextAutoInsertSpaceMode:(autoInsertSpaceMode)textAutoInsertSpaceMode{
	_textAutoInsertSpaceMode = textAutoInsertSpaceMode;
}
- (BOOL)isTextAutoInsertSpaceMode{
	return _textAutoInsertSpaceMode;
}
- (NSString*)text{
	if (_isAllowAutoInsertSpace) {
		if (_textAutoInsertSpaceMode == autoInsertSpaceMode_cellphone
			||
			_textAutoInsertSpaceMode == autoInsertSpaceMode_backcardNumber) {
			return [[super text] stringByReplacingOccurrencesOfString:@" " withString:@""];
		}
		if (_textAutoInsertSpaceMode == autoInsertSpaceMode_other
			&&
			_spaceIndexes.count != 0) {
			return [[super text] stringByReplacingOccurrencesOfString:@" " withString:@""];
		}
		return [super text];
	}else{
		return [super text];
	}
}
- (void)setText:(NSString *)text{
	[super setText:text];
}
#pragma mark private
- (CGFloat)labelHeight:(UILabel*)label{
	//	UIFont* labelFont = label.font;
	//	CGFloat height_label = labelFont.lineHeight;
	//	return height_label;
	
	NSString *str = @"请输入验证码中国永远国家Aa1234567890Zz";
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil];
	CGSize actsize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
	return actsize.height;
}
#pragma mark public method
- (void)textFieldTextDidChangeNotification:(NSNotification*)notification{
	WYCTextField* textField = notification.object;
	if (!_isAllowAutoInsertSpace) {
		return;
	}
	switch (_textAutoInsertSpaceMode) {
		case autoInsertSpaceMode_cellphone:
		{
			NSInteger firstSpace = 3;
			NSInteger secondSpace = 8;
			NSInteger fullLength = 12;
			NSString*tempString=[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];//首先获取到无空格的字符串
			NSMutableString* textString=[NSMutableString stringWithString:tempString];
			//				NSInteger numberOfChar=textString.length;
			if (textString.length > firstSpace) {
				[textString insertString:@" " atIndex:firstSpace];
			}
			if (textString.length > secondSpace) {
				
				[textString insertString:@" " atIndex:secondSpace];
			}
			[textField setText:textString];
			
			if (textString.length > fullLength) {
				[textField setText:[textString substringToIndex:fullLength + 1]];
			}
		}
			break;
			
		case autoInsertSpaceMode_backcardNumber:
		{
			NSString*tempString=[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];//首先获取到无空格的字符串
			if (tempString.length > _maxLength) {
				tempString = [tempString substringToIndex:_maxLength];
			}
			NSMutableString* textString=[NSMutableString stringWithString:tempString];
			NSInteger spaceCount = 0;
			NSInteger numberOfRemainder = 0;
			//				NSInteger spaceIndex = spaceCount * 5 - 1;
			
			spaceCount = tempString.length / 4;
			numberOfRemainder = tempString.length % 4;
			for (NSInteger index = spaceCount; index > 0;  index --) {
				if (numberOfRemainder == 0
					&&
					index != spaceCount) {
					[textString insertString:@" " atIndex:index * 4];
				}
				if (numberOfRemainder != 0) {
					[textString insertString:@" " atIndex:index * 4];
				}
			}
			[textField setText:textString];
			
		}
			break;
			
		case autoInsertSpaceMode_other:
		{
			NSInteger otherMode_maxSpaceCount = _spaceIndexes.count;
			if (otherMode_maxSpaceCount < 1
				&&
				textField.text.length > _maxLength) {
				NSString* newString = [textField.text substringToIndex:_maxLength];
				[textField setText:newString];
				return;
			}
			NSInteger spaceArr[otherMode_maxSpaceCount];
			NSInteger count = 0;
			for (NSNumber* numberObj in _spaceIndexes) {
				NSInteger spaceIndex = [numberObj integerValue];
				spaceArr[count] = spaceIndex;
				count ++;
			}
			//数组排序 选择排序 大->小()
			for (NSInteger index = 0; index < otherMode_maxSpaceCount - 1; index ++) {
				NSInteger maxIndex = index;//角标
				NSInteger maxNum = spaceArr[index];
				for (NSInteger otherIndex = index + 1; otherIndex < otherMode_maxSpaceCount;  otherIndex ++) {
					NSInteger j = spaceArr[otherIndex];
					if (maxNum < j) {
						maxNum = j;
						maxIndex = otherIndex;
					}
				}
				if (index != maxIndex) {
					NSInteger numTemp = spaceArr[index];
					spaceArr[index] = spaceArr[maxIndex];
					spaceArr[maxIndex] = numTemp;
				}
				
			}
			//排序结束
			for (NSInteger index = 0; index < otherMode_maxSpaceCount; index ++) {
			}
			NSString*tempString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];//首先获取到无空格的字符串
			if (tempString.length > _maxLength) {
				tempString = [tempString substringToIndex:_maxLength];
			}
			NSMutableString* textString = [NSMutableString stringWithString:tempString];
			
			
			//数组元素个数为零
			if (otherMode_maxSpaceCount < 1) {
				[textField setText:textString];
				return;
			}
			
			//字符串长度减一，小于 从左边数第一个空格的下角标
			if ((NSInteger)tempString.length - 1 < spaceArr[otherMode_maxSpaceCount - 1]) {
				[textField setText:textString];
				return;
			}
			for (NSInteger index = 0; index < otherMode_maxSpaceCount; index ++) {
				NSInteger lastSpaceIndex = spaceArr[index];
				if ((NSInteger)tempString.length - 1 >= lastSpaceIndex) {
					for (NSInteger otherIndex = index; otherIndex < otherMode_maxSpaceCount; otherIndex ++) {
						[textString insertString:@" " atIndex:spaceArr[otherIndex]];
					}
					break;
				}
			}
			[textField setText:textString];
			
			
		};
			
			break;
			
		default:
			break;
	}
}

//- (void)test{
//
//	//根据计算结果重新设置UILabel的尺寸
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



