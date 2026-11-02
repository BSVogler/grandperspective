#import "WriteTaskInput.h"


@implementation WriteTaskInput

- (instancetype) initWithAnnotatedTreeContext:(AnnotatedTreeContext *)context
                                         path:(NSURL *)path {
  return [self initWithAnnotatedTreeContext: context path: path options: nil];
}

- (instancetype) initWithAnnotatedTreeContext:(AnnotatedTreeContext *)context
                                         path:(NSURL *)path
                                      options:(id)options {
  if (self = [super init]) {
    _annotatedTreeContext = context;
    _path = path;
    _options = options;
  }
  
  return self;
}


@end
