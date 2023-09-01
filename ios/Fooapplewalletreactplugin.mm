#import "Fooapplewalletreactplugin.h"

#import <React/RCTUtils.h>
#import <FooAppleWallet/FooAppleWallet-umbrella.h>

@interface Fooapplewalletreactplugin () <FOInAppProtocol>

@property (copy, nonatomic) RCTPromiseResolveBlock provisioningResolveBlock;
@property (copy, nonatomic) RCTPromiseRejectBlock provisioningRejectBlock;

@end

@implementation Fooapplewalletreactplugin

+ (instancetype)sharedInstance
{
    static Fooapplewalletreactplugin *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Fooapplewalletreactplugin alloc] init];
    });
    return sharedInstance;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setHostName:(NSString *)hostName
                  andPath:(NSString *)path
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
   
    [FOAppleWallet setHostName:hostName andPath:path];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(deviceSupportsAppleWallet :(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isDeviceSupportsAppleWallet = [FOInAppProvisioning deviceSupportsAppleWallet];
    resolve(@(isDeviceSupportsAppleWallet));
}

RCT_EXPORT_METHOD(isCardAddedToLocalWalletWithCardSuffix:(NSString *)cardSuffix
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isCardAdded = [FOInAppProvisioning isCardAddedToLocalWalletWithCardSuffix:cardSuffix];
    resolve(@(isCardAdded));
}

RCT_EXPORT_METHOD(isCardAddedToRemoteWalletWithCardSuffix:(NSString *)cardSuffix
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isCardAdded = [FOInAppProvisioning isCardAddedToRemoteWalletWithCardSuffix:cardSuffix];
    resolve(@(isCardAdded));
}

RCT_EXPORT_METHOD(addCardForUserId:(nullable NSString *)userId
                  deviceId:(nullable NSString *)deviceId
                  cardId:(NSString *)cardId
                  cardHolderName:(NSString *)cardHolderName
                  cardPanSuffix:(NSString *)cardPanSuffix
                  sessionId:(nullable NSString *)sessionId
                  localizedDescription:(nullable NSString *)localizedDescription
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock = resolve;
    [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *presentedViewController = RCTPresentedViewController();
        [FOInAppProvisioning addCardForUserId:userId deviceId:deviceId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix sessionId:sessionId localizedDescription:localizedDescription inViewController:presentedViewController delegate:self];
    });
}

RCT_EXPORT_METHOD(addCardForUserIdWithPanAndExpiry:(nullable NSString *)userId
                  deviceId:(nullable NSString *)deviceId
                  cardId:(NSString *)cardId
                  cardHolderName:(NSString *)cardHolderName
                  cardPanSuffix:(NSString *)cardPanSuffix
                  localizedDescription:(nullable NSString *)localizedDescription
                  pan:(NSString *)pan
                  expiryDate:(NSString *)expiryDate
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock = resolve;
    [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *presentedViewController = RCTPresentedViewController();
        [FOInAppProvisioning addCardForUserId:userId deviceId:deviceId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription pan:pan expiryDate:expiryDate inViewController:presentedViewController delegate:self];
    });
}

- (void)didFinishAddingCard:(nullable PKPaymentPass *)pass error:(FOInAppAddCardError)error errorMessage:(nullable NSString *)errorMessage {
    NSLog(@"DidFinishAddingCard result: %u, message: %@", error, errorMessage);
    NSString *result = [[NSString alloc] initWithFormat:@"%u", error];
    
    if (error == 0) {
        [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock(result);
    } else {
        NSError *error = [[NSError alloc] initWithDomain:@"FOInAppAddCardError" code:(NSInteger)[result intValue] userInfo:nil];
        [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock(result, errorMessage, error);
    }
}

@end
