#import "ScanTaskOutput.h"

#import "AlertMessage.h"
#import "TreeContext.h"

@implementation ScanTaskOutput

+ (instancetype) scanTaskOutput:(TreeContext *)treeContext alert:(AlertMessage *)alert {
  return [[ScanTaskOutput alloc] initWithTreeContext: treeContext alert: alert];
}

+ (instancetype) failedScanTaskOutput:(AlertMessage *)alert {
  return [[ScanTaskOutput alloc] initWithTreeContext: nil alert: alert];
}

- (instancetype) initWithTreeContext:(TreeContext *)treeContext alert:(AlertMessage *)alert {
  if (self = [super init]) {
    NSAssert(treeContext != nil || alert != nil, @"treeContext or alert must be set.");

    _treeContext = treeContext;
    _alert = alert;
  }
  return self;
}


@end
