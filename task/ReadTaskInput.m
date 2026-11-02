#import "ReadTaskInput.h"


@implementation ReadTaskInput

- (instancetype) initWithSourceUrl:(NSURL *)sourceUrl {
  if (self = [super init]) {
    _sourceUrl = sourceUrl;
  }
  
  return self;
}


@end
