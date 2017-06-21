//
//  MainVC.m
//  EpamCalculator
//
//  Created by Andrei Palonski on 20.06.17.
//  Copyright © 2017 Andrei Palonski. All rights reserved.
//

#import "MainVC.h"
#import "CustomButton.h"

@interface MainVC ()

@end

@implementation MainVC
@synthesize currentInput = _currentInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:88.0/255.0 blue:85.0/255.0 alpha:1.0]];
  
  [self setupUI];
  self.isStillTyping = NO;
  self.firstOperand = 0;
  self.secondOperand = 0;
  self.operationSign = @"";
  
}



#pragma mark - кастомные сеттер и геттер

// кастомные сеттер и геттер
//- (void)setCurrentInput:(double)newValue {
//  self.resultLabel.text = [NSString stringWithFormat:@"%.01f", newValue];
//  self.isStillTyping = NO;
//}

////// кастомный сеттер с убранным лишним 0
- (void)setCurrentInput:(double)newValue {
  NSString* value = [NSString stringWithFormat:@"%f", newValue];
  NSArray* valueArray = [value componentsSeparatedByString:@"."];
 // NSLog(@"%@", [NSString stringWithFormat:@"valueArray = %@", valueArray]);

  if ([valueArray[1]  isEqual: @"000000"]) {
    self.resultLabel.text = [NSString stringWithFormat:@"%@", valueArray[0]];
  } else {
    self.resultLabel.text = [NSString stringWithFormat:@"%.010f", newValue];
  }
  
  self.isStillTyping = NO;
}

  // кастомный геттер который сразу возвращает дабл из текста
- (double)getCurrentInput {
  _currentInput = [self.resultLabel.text doubleValue];
  return _currentInput;
}




#pragma mark - создание UI

  // нстройка UI
- (void)setupUI {
  
  // добавление и настройка лэйбла в который будет выводится результат вычисления
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height / 6)];
  label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:88.0/255.0 blue:85.0/255.0 alpha:0.3];
  [label setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:65.0]];
  label.text = @"0";
  label.textColor = [UIColor whiteColor];
  label.layer.cornerRadius = 5.0;
  label.layer.masksToBounds = YES;
  label.layer.borderWidth = 1.0;
  label.layer.borderColor = [UIColor redColor].CGColor;
  label.layer.shadowColor = [UIColor blackColor].CGColor;
  label.layer.shadowOpacity = 0.8;
  label.layer.shadowRadius = 5.0;
  label.layer.shadowOffset = CGSizeMake(2.0, 2.0);
  label.textAlignment = NSTextAlignmentRight;
  label.adjustsFontSizeToFitWidth = YES;
  label.minimumScaleFactor = 0.3;
  self.resultLabel = label;

  [self.view addSubview:label];
  
  
  //  долгая и мучительная настройка кнопок
  CustomButton* clearBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame),
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height,
                                                                                         self.view.frame.size.width / 4,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"C"];
  [clearBtn addTarget:self action:@selector(clearLabel:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* plusMinusBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + clearBtn.frame.size.width,
                                                                                             CGRectGetMinY(self.view.frame) + label.frame.size.height,
                                                                                             self.view.frame.size.width / 4,
                                                                                             (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"+/−"];
    [plusMinusBtn addTarget:self action:@selector(plusMinusSign:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* dotBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + clearBtn.frame.size.width + plusMinusBtn.frame.size.width,
                                                                                       CGRectGetMinY(self.view.frame) + label.frame.size.height, self.view.frame.size.width / 4,
                                                                                       (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"."];
  [dotBtn addTarget:self action:@selector(dotPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* plusBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + clearBtn.frame.size.width + plusMinusBtn.frame.size.width + dotBtn.frame.size.width,
                                                                                        CGRectGetMinY(self.view.frame) + label.frame.size.height,
                                                                                        self.view.frame.size.width / 4,
                                                                                        (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"+"];
  [plusBtn addTarget:self action:@selector(simpleOperations:) forControlEvents:UIControlEventTouchUpInside];
 // [plusBtn addTarget:self action:@selector(equalSign:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* sevenBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame),
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height,
                                                                                         self.view.frame.size.width / 4,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"7"];
  [sevenBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* eightBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + sevenBtn.frame.size.width,
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height,
                                                                                         self.view.frame.size.width / 4,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"8"];
  [eightBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* nineBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + sevenBtn.frame.size.width + eightBtn.frame.size.width,
                                                                                        CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height,
                                                                                        self.view.frame.size.width / 4,
                                                                                        (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"9"];
  [nineBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* minusBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + sevenBtn.frame.size.width + eightBtn.frame.size.width + eightBtn.frame.size.width,
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height,
                                                                                         self.view.frame.size.width / 4,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"−"];
  [minusBtn addTarget:self action:@selector(simpleOperations:) forControlEvents:UIControlEventTouchUpInside];
 // [minusBtn addTarget:self action:@selector(equalSign:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* fourBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame),
                                                                                        CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height,
                                                                                        self.view.frame.size.width / 4,
                                                                                        (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"4"];
  [fourBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* fiveBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + fourBtn.frame.size.width,
                                                                                        CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height,
                                                                                        self.view.frame.size.width / 4,
                                                                                        (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"5"];
  [fiveBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* sixBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + fourBtn.frame.size.width + fiveBtn.frame.size.width,
                                                                                       CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height,
                                                                                       self.view.frame.size.width / 4,
                                                                                       (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"6"];
  [sixBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* multipleBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + fourBtn.frame.size.width + fiveBtn.frame.size.width + sixBtn.frame.size.width,
                                                                                            CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height,
                                                                                            self.view.frame.size.width / 4,
                                                                                            (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"✕"];
  [multipleBtn addTarget:self action:@selector(simpleOperations:) forControlEvents:UIControlEventTouchUpInside];
  //[multipleBtn addTarget:self action:@selector(equalSign:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* oneBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame),
                                                                                       CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height,
                                                                                       self.view.frame.size.width / 4,
                                                                                       (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"1"];
  [oneBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* twoBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + oneBtn.frame.size.width,
                                                                                       CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height,
                                                                                       self.view.frame.size.width / 4,
                                                                                       (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"2"];
  [twoBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* threeBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + oneBtn.frame.size.width + twoBtn.frame.size.width,
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height,
                                                                                         self.view.frame.size.width / 4,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"3"];
  [threeBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* divideBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + oneBtn.frame.size.width + twoBtn.frame.size.width + threeBtn.frame.size.width,
                                                                                          CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height,
                                                                                          self.view.frame.size.width / 4,
                                                                                          (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"÷"];
  [divideBtn addTarget:self action:@selector(simpleOperations:) forControlEvents:UIControlEventTouchUpInside];
  //[divideBtn addTarget:self action:@selector(equalSign:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* squareBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame),
                                                                                          CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height + oneBtn.frame.size.height,
                                                                                          self.view.frame.size.width / 4,
                                                                                          (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"√"];
  [squareBtn addTarget:self action:@selector(squareRoot:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* zeroBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + squareBtn.frame.size.width,
                                                                                        CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height + oneBtn.frame.size.height,
                                                                                        self.view.frame.size.width / 4,
                                                                                        (self.view.frame.size.height - label.frame.size.height) / 5)  andText:@"0"];
  [zeroBtn addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  CustomButton* equalBtn = [[CustomButton alloc] initWithFrameMyCustomBtnWIth:CGRectMake(CGRectGetMinX(self.view.frame) + squareBtn.frame.size.width + zeroBtn.frame.size.width,
                                                                                         CGRectGetMinY(self.view.frame) + label.frame.size.height + clearBtn.frame.size.height + sevenBtn.frame.size.height + fourBtn.frame.size.height + oneBtn.frame.size.height,
                                                                                         self.view.frame.size.width / 2,
                                                                                         (self.view.frame.size.height - label.frame.size.height) / 5) andText:@"="];
  [equalBtn addTarget:self action:@selector(equalSign:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:clearBtn];
  [self.view addSubview:plusMinusBtn];
  [self.view addSubview:dotBtn];
  [self.view addSubview:plusBtn];
  
  [self.view addSubview:sevenBtn];
  [self.view addSubview:eightBtn];
  [self.view addSubview:nineBtn];
  [self.view addSubview:minusBtn];
  
  [self.view addSubview:fourBtn];
  [self.view addSubview:fiveBtn];
  [self.view addSubview:sixBtn];
  [self.view addSubview:multipleBtn];
  
  [self.view addSubview:oneBtn];
  [self.view addSubview:twoBtn];
  [self.view addSubview:threeBtn];
  [self.view addSubview:divideBtn];
  
  [self.view addSubview:squareBtn];
  [self.view addSubview:zeroBtn];
  [self.view addSubview:equalBtn];
  
}




#pragma mark - методы обработки нажатия кнопок и арифметических операций

  // метод ввода чисел в лейбл с проверками
- (void)numberPressed:(UIButton*)sender {
  
  NSString* number = sender.currentTitle;
  
  if (self.isStillTyping == YES) {
    if (_resultLabel.text.length < 20) {
      self.resultLabel.text = [NSString stringWithFormat:@"%@%@", self.resultLabel.text, number];
    };
  } else {
    self.resultLabel.text = [NSString stringWithFormat:@"%@", number];
    self.isStillTyping = YES;
  }

}

  // метод для работы с 2мя операндами с операторами +-/*
- (void)simpleOperations:(UIButton*)sender {

  self.operationSign = sender.currentTitle; // получаем знак операции
  self.firstOperand = self.currentInput;    // первое введенное число приравниваем конвертированному в дабл из лейбла
  self.isStillTyping = NO;                  // говорим, что превое число введено и вводится будет уже второе
  self.isDotPlaced = NO;
  
}

//- (void)operateWithTwoOperands:(double (^)(double, double))operation {
//  self.currentInput = operation(self.firstOperand, self.secondOperand);
//  self.isStillTyping = NO;
//}

// метод вычисления после нажатия на =
- (void)equalSign:(UIButton*)sender {
  
  if (self.isStillTyping == YES) {
    self.secondOperand = self.currentInput; // второе введенное число приравниваем конвертированному в дабл из лейбла
  }
  
  self.isDotPlaced = NO;
  
  // операции с операндами в зависимости от нажатой кнопки
  
  if ([self.operationSign  isEqual: @"+"]) {
    self.currentInput = self.firstOperand + self.secondOperand;
    self.isStillTyping = NO;
  }
  
  if ([self.operationSign  isEqual: @"-"]) {
    self.currentInput = self.firstOperand - self.secondOperand;
    self.isStillTyping = NO;
  }
  
  if ([self.operationSign  isEqual: @"✕"]) {
    self.currentInput = self.firstOperand * self.secondOperand;
    self.isStillTyping = NO;
  }
  
  if ([self.operationSign  isEqual: @"÷"]) {
    self.currentInput = self.firstOperand / self.secondOperand;
    self.isStillTyping = NO;
  }
  
}

  // метод очистки лейбла и сброса всех переменных
- (void)clearLabel:(UIButton*)sender {
  self.firstOperand = 0;
  self.secondOperand = 0;
  self.currentInput = 0;
  self.resultLabel.text = @"0";
  self.isStillTyping = NO;
  self.isDotPlaced = NO;
  self.operationSign = @"";
}

  // метод переключения числа с положительного на отрицательный
- (void)plusMinusSign:(UIButton*)sender {
  self.currentInput = -self.currentInput;
}

  // метод добавления . разделяющей дробную часть
- (void)dotPressed:(UIButton*)sender {
  
  if ((self.isStillTyping == YES) && (self.isDotPlaced == NO)) {
    self.resultLabel.text = [NSString stringWithFormat:@"%@.", self.resultLabel.text];
    self.isDotPlaced = YES;
  } else if ((self.isStillTyping == NO) && (self.isDotPlaced == NO)) {
    self.resultLabel.text = @"0.";
  }
  
}

// метод извлечения квадратного корня
- (void)squareRoot:(UIButton*)sender {
  
  self.currentInput = sqrt(self.currentInput);
}


@end
