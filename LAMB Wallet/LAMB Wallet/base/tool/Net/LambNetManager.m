//
//  LambNetManager.m
//  LAMB Wallet
//
//  Created by fei on 2020/11/19.
//  Copyright © 2020 fei. All rights reserved.
//

#import "LambNetManager.h"
#import "MBProgressHUD+MJ.h"
typedef NS_ENUM(NSInteger, kLambRequestType){
    kGetType,
    kPostType,
};
static LambNetManager *instance = nil;

@interface LambNetManager ()

@property (nonatomic,strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LambNetManager

+ (instancetype) shareInstance {
    
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[LambNetManager alloc]init];
        });
    }
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initDate];
    }
    return self;
}

- (void) initDate {
    _baseUrl = DEBUGBASEURL;
}

+ (void)GET:(NSString *)urlString parameters:(id)parameters showHud:(BOOL) hud success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure
{
 
    [LambNetManager request:kGetType url:urlString parameters:parameters showHud:hud success:success failure:failure];
}

+ (void)POST:(NSString *)urlString parameters:(id)parameters showHud:(BOOL) hud success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure
{
   
    [LambNetManager request:kPostType url:urlString parameters:parameters showHud:hud success:success failure:failure];
}

+ (void)request:(kLambRequestType) requestType url:(NSString *)urlString parameters:(id)parameters showHud:(BOOL)hud success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure{
    
    if (hud) {
        [MBProgressHUD showMessage:@"拼命加载中..."];
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[LambNetManager shareInstance].baseUrl,urlString];
    
//    urlString = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlString = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];

    
    switch (requestType) {
        case kGetType:
        {
            [[[LambNetManager shareInstance]sessionManager] GET:urlString parameters:parameters headers:parameters  progress: nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                
                NSLog(@"=====> %@\n =====> %@",requestUrl,result);
                
                [LambNetManager requestFinish:result error:nil showHud:hud success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [LambNetManager requestFinish:nil error:error showHud:hud success:success failure:failure];
            }];
        }
            break;
        case kPostType:
        {
            [[[LambNetManager shareInstance]sessionManager] POST:urlString parameters:parameters headers:parameters  progress: nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                NSLog(@"=====> %@\n =====> %@",requestUrl,result);
                [LambNetManager requestFinish:result error:nil showHud:hud success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [LambNetManager requestFinish:nil error:error showHud:hud success:success failure:failure];
            }];
        }
            break;
    }
}

+ (void)requestFinish:(id)responseObject error:(NSError *) error showHud:(BOOL)hud success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure{
    if (responseObject) {
        if (success) {
            success(responseObject);
        }
    }
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    if (hud) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }
}
 
+ (void)uploadMorePost:(NSString *)urlString parameters:(id)parameters UploadImage:(NSArray *)imageArray ImageKey:(NSArray *)imageKeys success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    if (imageKeys.count == 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@为空",imageKeys]];
        return ;
    }
    if (imageArray.count == 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@为空",imageArray]];
        return;
    }
    [MBProgressHUD showMessage:@"拼命加载中..."];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[LambNetManager shareInstance].baseUrl,urlString];
    
    urlString = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];

    [[[LambNetManager shareInstance]sessionManager] POST:urlString parameters:parameters headers:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        UIImage *image = imageArray[i];
        NSData *data = UIImageJPEGRepresentation(image, 0.7);
        [formData appendPartWithFileData:data name:((imageKeys.count > 1) ? (imageKeys[i]) : (imageKeys.firstObject)) fileName:fileName mimeType:@"image/png"];
    }
    } progress: nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [LambNetManager requestFinish:responseObject error:nil showHud:YES success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LambNetManager requestFinish:nil error:error showHud:YES success:success failure:failure];
    }];
}

+ (void)ReachabilityStatus:(void (^)(id string))netStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                
                if (netStatus) {
                    netStatus(@"未知网络类型");
                }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                if (netStatus) {
                    netStatus(@"无可用网络");
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                if (netStatus) {
                    netStatus(@"当前WIFE下");
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                if (netStatus) {
                    netStatus(@"使用蜂窝流量");
                }
                break;
                
            default:
                
                break;
        }
    }];
    [manager startMonitoring];
}


- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
//        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 20.0f;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet
                                                             setWithObjects:@"application/json",@"text/json",
                                                             @"text/plain", @"text/html",
                                                             nil];
        _sessionManager.requestSerializer.allowsCellularAccess = YES;
    }
    return _sessionManager;
}


- (void)setBaseUrl:(NSString *)baseUrl {
    if ([baseUrl containsString:@"http"]) {
        _baseUrl = baseUrl;
    }else{
        _baseUrl = [NSString stringWithFormat:@"http://%@",baseUrl];
    }
    _sessionManager = nil;
}

 
@end
