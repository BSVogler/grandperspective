#import "ScanTreeRoot.h"

#import "LogManager.h"

@implementation ScanTreeRoot

- (void) dealloc {
  os_log_info(LogManager.defaultLogManager.mainLog, "ScanTreeRoot-dealloc");
}

@end // @implementation ScanTreeRoot
