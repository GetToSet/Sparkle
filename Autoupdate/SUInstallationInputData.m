//
//  SUInstallationInputData.m
//  Sparkle
//
//  Created by Mayur Pawashe on 3/24/16.
//  Copyright © 2016 Sparkle Project. All rights reserved.
//

#import "SUInstallationInputData.h"
#import "SUInstallationType.h"

#ifdef _APPKITDEFINES_H
#error This is a "daemon-safe" class and should NOT import AppKit
#endif

static NSString *SURelaunchPathKey = @"SURelaunchPath";
static NSString *SUHostBundlePathKey = @"SUHostBundlePath";
static NSString *SUUpdateDirectoryPathKey = @"SUUpdateDirectoryPath";
static NSString *SUDownloadNameKey = @"SUDownloadName";
static NSString *SUDSASignatureKey = @"SUDSASignature";
static NSString *SUDecryptionPasswordKey = @"SUDecryptionPassword";
static NSString *SUInstallationTypeKey = @"SUInstallationType";

@implementation SUInstallationInputData

@synthesize relaunchPath = _relaunchPath;
@synthesize hostBundlePath = _hostBundlePath;
@synthesize updateDirectoryPath = _updateDirectoryPath;
@synthesize downloadName = _downloadName;
@synthesize dsaSignature = _dsaSignature;
@synthesize decryptionPassword = _decryptionPassword;
@synthesize installationType = _installationType;

- (instancetype)initWithRelaunchPath:(NSString *)relaunchPath hostBundlePath:(NSString *)hostBundlePath updateDirectoryPath:(NSString *)updateDirectoryPath downloadName:(NSString *)downloadName installationType:(NSString *)installationType dsaSignature:(NSString *)dsaSignature decryptionPassword:(nullable NSString *)decryptionPassword
{
    self = [super init];
    if (self != nil) {
        _relaunchPath = [relaunchPath copy];
        _hostBundlePath = [hostBundlePath copy];
        _updateDirectoryPath = [updateDirectoryPath copy];
        _downloadName = [downloadName copy];
        
        _installationType = [installationType copy];
        assert(SUValidInstallationType(_installationType));
        
        _dsaSignature = [dsaSignature copy];
        _decryptionPassword = [decryptionPassword copy];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    NSString *relaunchPath = [decoder decodeObjectOfClass:[NSString class] forKey:SURelaunchPathKey];
    if (relaunchPath == nil) {
        return nil;
    }
    
    NSString *hostBundlePath = [decoder decodeObjectOfClass:[NSString class] forKey:SUHostBundlePathKey];
    if (hostBundlePath == nil) {
        return nil;
    }
    
    NSString *updateDirectoryPath = [decoder decodeObjectOfClass:[NSString class] forKey:SUUpdateDirectoryPathKey];
    if (updateDirectoryPath == nil) {
        return nil;
    }
    
    NSString *downloadName = [decoder decodeObjectOfClass:[NSString class] forKey:SUDownloadNameKey];
    if (downloadName == nil) {
        return nil;
    }
    
    NSString *installationType = [decoder decodeObjectOfClass:[NSString class] forKey:SUInstallationTypeKey];
    if (!SUValidInstallationType(installationType)) {
        return nil;
    }
    
    NSString *dsaSignature = [decoder decodeObjectOfClass:[NSString class] forKey:SUDSASignatureKey];
    if (dsaSignature == nil) {
        return nil;
    }
    
    NSString *decryptionPassword = [decoder decodeObjectOfClass:[NSString class] forKey:SUDecryptionPasswordKey];
    
    return [self initWithRelaunchPath:relaunchPath hostBundlePath:hostBundlePath updateDirectoryPath:updateDirectoryPath downloadName:downloadName installationType:installationType dsaSignature:dsaSignature decryptionPassword:decryptionPassword];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.relaunchPath forKey:SURelaunchPathKey];
    [coder encodeObject:self.hostBundlePath forKey:SUHostBundlePathKey];
    [coder encodeObject:self.updateDirectoryPath forKey:SUUpdateDirectoryPathKey];
    [coder encodeObject:self.installationType forKey:SUInstallationTypeKey];
    [coder encodeObject:self.downloadName forKey:SUDownloadNameKey];
    [coder encodeObject:self.dsaSignature forKey:SUDSASignatureKey];
    if (self.decryptionPassword != nil) {
        [coder encodeObject:self.decryptionPassword forKey:SUDecryptionPasswordKey];
    }
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
