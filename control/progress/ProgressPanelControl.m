#import "ProgressPanelControl.h"

#import "PreferencesPanelControl.h"
#import "LogManager.h"

extern NSString  *NumFoldersProcessedKey;
extern NSString  *CurrentFolderPathKey;
extern NSString  *EstimatedProgressKey;
extern NSString  *StableFolderPathKey;


@interface ProgressPanelControl (PrivateMethods)

- (void) updatePanel;

- (void) updateProgressDetails:(NSString *)currentPath;
- (void) updateProgressSummary:(int)numProcessed;
- (void) updateProgressEstimate:(float)progressEstimate;

@end


@implementation ProgressPanelControl

- (instancetype) initWithTaskExecutor:(NSObject <TaskExecutor> *)taskExecutorVal {
  if (self = [super initWithWindow: nil]) {
    taskExecutor = taskExecutorVal;

    refreshRate = [NSUserDefaults.standardUserDefaults floatForKey: ProgressPanelRefreshRateKey];
    if (refreshRate <= 0) {
      os_log(LogManager.defaultLogManager.mainLog,
             "Invalid value for progressPanelRefreshRate.");
      refreshRate = 1;
    }
  }
  
  return self;
}


- (void) dealloc {
  NSAssert(cancelCallback==nil, @"cancelCallback not nil.");
}


- (NSString *)windowNibName {
  return @"ProgressPanel";
}

- (void) windowDidLoad {
  if (@available(macOS 10.11, *)) {
    self->progressSummary.font = [NSFont monospacedDigitSystemFontOfSize: 0
                                                                  weight: NSFontWeightRegular];
  }

  summaryToolTip = nil;
  summaryToolTipTag = 0;

  [self updateProgressDetails: @""];
  [self updateProgressSummary: 0];

  self.window.title = self.windowTitle;
}


- (NSObject <TaskExecutor> *)taskExecutor {
  return taskExecutor;
}


- (void) taskStartedWithInput:(id)taskInput
               cancelCallback:(NSObject *)callback
                     selector:(SEL)selector {
  NSAssert(cancelCallback == nil, @"Callback already set.");
  
  cancelCallback = callback;
  cancelCallbackSelector = selector;

  // Update title. It may change depending on task input
  self.window.title = self.windowTitle;

  [self.window center];
  [self.window orderFront: self];

  [self updateProgressDetails: [self pathFromTaskInput: taskInput]];
  [self updateProgressSummary: 0];
  [self updateProgressEstimate: 0];

  taskRunning = YES;
  [self updatePanel];
}

- (void) taskStopped {
  NSAssert(cancelCallback != nil, @"Callback already nil.");
  
  cancelCallback = nil;
  
  [self.window close];

  taskRunning = NO; 
}


- (IBAction) abort:(id)sender {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  // The cancel selector returns void.
  [cancelCallback performSelector: cancelCallbackSelector];
#pragma clang diagnostic pop
 
  // No need to invoke "taskStopped". This is the responsibility of the caller of "taskStarted".
}

@end // @implementation ProgressPanelControl


@implementation ProgressPanelControl (PrivateMethods)

- (void) updatePanel {
  if (!taskRunning) {
    return;
  }

  NSDictionary  *dict = [self progressInfo];
  if (dict != nil) {
    [self updateProgressDetails: dict[StableFolderPathKey]];
    [self updateProgressSummary: [dict[NumFoldersProcessedKey] intValue]];
    [self updateProgressEstimate: [dict[EstimatedProgressKey] floatValue]];
  }

  // Schedule another update
  [self performSelector: @selector(updatePanel) withObject: 0 afterDelay: refreshRate];
}

- (void) updateProgressDetails:(NSString *)currentPath {
  progressDetails.stringValue =
    (currentPath != nil)
    ? [NSString stringWithFormat: self.progressDetailsFormat, currentPath]
    : @"";

  // Update the tooltip only when the summary changed. This ensures that the tooltip shows up when
  // the mouse hovers over the control while the path stays the same for long enough.
  if (![summaryToolTip isEqualToString: progressDetails.stringValue]) {
    NSView* view = progressDetails.superview;
    if (summaryToolTip != nil) {
      [view removeToolTip: summaryToolTipTag];
    }

    summaryToolTip = progressDetails.stringValue;
    summaryToolTipTag = [view addToolTipRect: progressDetails.frame
                                       owner: summaryToolTip
                                    userData: nil];
  }
}

- (void) updateProgressSummary:(int)numProcessed {
  progressSummary.stringValue =
    [NSString localizedStringWithFormat: self.progressSummaryFormat, numProcessed];
}

- (void) updateProgressEstimate:(float)progressEstimate {
  progressIndicator.doubleValue = progressEstimate;
}

@end // @implementation ProgressPanelControl (PrivateMethods)


