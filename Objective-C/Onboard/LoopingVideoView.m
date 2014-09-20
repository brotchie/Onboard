#import "LoopingVideoView.h"

@interface LoopingVideoView ()
@property (retain, nonatomic) AVPlayer *player;
@property (retain, nonatomic) AVPlayerItem *playerItem;
@property (retain, nonatomic) AVPlayerLayer *playerLayer;
@property (retain, nonatomic) id videoEndObserver;
@end

@implementation LoopingVideoView

- (id)initWithURL:(NSURL *)videoURL
{
    self = [super init];
    if (self) {
        AVURLAsset *asset = [AVURLAsset assetWithURL:videoURL];
        self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
        self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        
        [self.layer addSublayer:self.playerLayer];
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
       
        NSValue *time = [NSValue valueWithCMTime:asset.duration];
        self.videoEndObserver = [self.player addBoundaryTimeObserverForTimes:@[time] queue:dispatch_get_main_queue() usingBlock:^{
            [self.player.currentItem seekToTime:CMTimeMakeWithSeconds(0.0, 1.0)];
            [self.player play];
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

@end
