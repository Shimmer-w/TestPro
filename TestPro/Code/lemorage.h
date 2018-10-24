//
//  Lemorage.h
//  lemorage
//
//  Created by 王炜光 on 2018/10/22.
//  Copyright © 2018 lemix. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface lemorage : NSObject
/**
 启动lemorage
 
 @param workspachePath 永久存放目录 直到调用[Lemorage expiredAllLongTermUrl]方法后才失效
 @param tempPath 临时存放目录 [Lemorage startUp]方法时URL就会失效，也可以通过[Lemorage expiredAllShortTermUrl]
 */
+ (void)startUpForWorkspacePath:(NSString *)workspachePath tempPath:(NSString *)tempPath;
/**
 将二进制数据存储到沙盒中的文件，然后生成指向沙盒中二进制文件的Lemorage格式的URL
 
 @param data 要生成LemorageURL的data对象
 @param longTerm 是否永久有效
 @return 生成的LemorageURL
 */
+ (NSString *)generateLemageUrl: (NSData *)data
                       longTerm: (BOOL)longTerm;

/**
 根据LemorageURL加载对应的NSData数据，如果用户传入的LemorageURL有误或已过期，会返回nil
 
 @param lemorageURL LemorageURL字符串
 @param complete 根据LemorageURL逆向转换回来的图片NSData数据对象，如果URL无效会返回nil
 */
+ (void)loadDataByLemorageURL: (NSString *)lemorageURL complete:(void(^)(NSData *imageData))complete;
/**
 让所有长期的LemorageURL失效
 原理：删除所有本地长期LemorageURL对应的沙盒图片文件
 */
+ (void)expiredAllLongTermUrl;
/**
 让所有短期的LemorageURL失效
 原理：删除所有本地短期LemorageURL对应的沙盒图片文件
 */
+ (void)expiredAllShortTermUrl;

+ (void)deleteDataWithTermUrl:(NSString *)lemorageURL;
@end

//NS_ASSUME_NONNULL_END
