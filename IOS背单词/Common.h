// 1.判断是否为iOS7
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


// 2.获得RGB颜色
#define SWColor(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//3.引用UIImage+MJ.h分类
#import "UIImage+MJ.h"

// 4.自定义Log
#ifdef DEBUG
#define SWLog(...) NSLog(__VA_ARGS__)
#else
#define SWLog(...)
#endif

// 5.simple和detail控制器的  宏

//普通字体
#define  SWCommonFont  [UIFont systemFontOfSize:16]
//单词的字体
#define  SWBigFont  [UIFont systemFontOfSize:22]
//各控件的间距
#define  SWPadding  15
//顶部间距
#define  SWTopPadding   (IOS7 ? 90 : 26)
//cell 顶部间距
#define  SWCellTopPadding   5


// 6.文件存储路径
#define  SWFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"words.plist"];
#define  SWReviseFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"wordsRevise.plist"];
#define  SWRemainFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"wordsRemain.plist"];
// 7.今日学习控件的高度
#define SWCommonH   30
