#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LoopingVideoView : UIView
- (id)initWithURL:(NSURL *)videoURL;
- (void)play;
- (void)pause;
@end
