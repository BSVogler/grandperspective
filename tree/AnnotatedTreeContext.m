#import "AnnotatedTreeContext.h"

#import "TreeContext.h"

#import "FilterSet.h"
#import "FileItemTest.h"

@implementation AnnotatedTreeContext

+ (instancetype) annotatedTreeContext:(TreeContext *)treeContext {
  return (treeContext == nil 
          ? nil
          : [[AnnotatedTreeContext alloc] initWithTreeContext: treeContext]);
}

+ (instancetype) annotatedTreeContext:(TreeContext *)treeContext
                             comments:(NSString *)comments {
  return (treeContext == nil
          ? nil
          : [[AnnotatedTreeContext alloc] initWithTreeContext: treeContext comments: comments]);
}

- (instancetype) initWithTreeContext:(TreeContext *)treeContext {
  FileItemTest  *test = treeContext.filterSet.fileItemTest;

  return [self initWithTreeContext: treeContext
                          comments: ((test != nil) ? test.description : @"")];
}

- (instancetype) initWithTreeContext:(TreeContext *)treeContext
                            comments:(NSString *)comments {
  if (self = [super init]) {
    NSAssert(treeContext != nil, @"TreeContext must be set.");
  
    _treeContext = treeContext;
    
    // Create a copy of the string, to ensure it is immutable.
    _comments = comments != nil ? [NSString stringWithString: comments] : @"";
  }
  return self;
}


@end
