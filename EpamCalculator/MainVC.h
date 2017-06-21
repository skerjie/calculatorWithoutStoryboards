//
//  MainVC.h
//  EpamCalculator
//
//  Created by Andrei Palonski on 20.06.17.
//  Copyright © 2017 Andrei Palonski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController

@property (nonatomic, weak) UILabel* resultLabel; // ярлык в котормом идут вычисления
@property (nonatomic, assign) BOOL isStillTyping; // если начальный 0 при печатании не является продолжением числа, то нужно от него избавится
@property (nonatomic, assign) BOOL isDotPlaced;   // ставилась ли точка для числа дробного, т.к. 2 раза ставить нельзя
@property (nonatomic) double firstOperand;        // 1ый операнд
@property (nonatomic) double secondOperand;       // 2ой операнд
@property (nonatomic, copy) NSString* operationSign;  // знак нажатой операции +-/*
@property (nonatomic, getter=getCurrentInput,setter=setCurrentInput:) double currentInput;  // переменная которая переводит в дабл и хранит число введенное в лейбл

- (void)numberPressed:(UIButton*)sender;
- (void)simpleOperations:(UIButton*)sender;
- (void)equalSign:(UIButton*)sender;
- (void)clearLabel:(UIButton*)sender;
- (void)plusMinusSign:(UIButton*)sender;
- (void)dotPressed:(UIButton*)sender;
- (void)squareRoot:(UIButton*)sender;

@end
