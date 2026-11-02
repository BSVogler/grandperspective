#import <Cocoa/Cocoa.h>


@interface PeekingEnumerator : NSObject {
  NSEnumerator  *enumerator;
  // Not retained, as for efficiency it should not be (auto-)released.
  __unsafe_unretained id  nextObject;
}

@property (nonatomic, readonly) id peekObject;

- (instancetype) initWithEnumerator:(NSEnumerator *)enumerator NS_DESIGNATED_INITIALIZER;

- (id) nextObject;

@end
