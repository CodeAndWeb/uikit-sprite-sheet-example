/**
 * CALayer class to display frames and animations from a sprite sheet
 * created with TexturePacker
 *
 * www.codeandweb.com/texturepacker
 *
 * Copyright (c) 2013 by CodeAndWeb / Andreas Loew
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#pragma clang diagnostic push EVERY_WARNING
#pragma clang diagnostic ignored "-Wshadow"
#pragma clang diagnostic ignored "-Wnon-virtual-dtor"
#pragma clang diagnostic ignored "-Wfloat-equal"
#pragma clang diagnostic ignored "-Wpadded"
#pragma clang diagnostic ignored "-Wweak-vtables"
#pragma clang diagnostic ignored "-Wdisabled-macro-expansion"
#pragma clang diagnostic ignored "-Wundef"
#pragma clang diagnostic ignored "-Wdisabled-macro-expansion"
#pragma clang diagnostic ignored "-Wobjc-interface-ivars"
#pragma clang diagnostic ignored "-Wdocumentation"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wassign-enum"
#pragma clang diagnostic ignored "-Wformat-nonliteral"

#import "CAWSpriteCoreLayer.h"

@implementation CAWSpriteCoreLayer

@synthesize spriteData;
@synthesize frameIndex;
@synthesize atlasSize;
@synthesize numFrames;
@synthesize showLastFrame;
@synthesize subLayer;
@synthesize stillFrame;
@synthesize animationFrameExtension;

-(id)init
{
    if ((self = [super init]))
    {
        showLastFrame = false;
        state = TPSPRITE_INIT;
        stillFrame = nil;
        currentAnimation = nil;
        [self addSublayer:subLayer];
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    return [key isEqualToString:@"frameIndex"];
}

- (void) setSpriteData:(NSDictionary *)spriteData_ andImage:(UIImage *)img_
{
    self.contents = (id)img_.CGImage;
    self.spriteData = spriteData_;
}

- (void) setContents:(id)contents_
{
    [super setContents:contents_];
    CGImageRef img = (__bridge CGImageRef) contents_;
    atlasSize = CGSizeMake(CGImageGetWidth(img), CGImageGetHeight(img));
}

- (void)playAnimation:(NSString *)frameNames withRate:(float)frameRate andRepeat:(float)repeatCount
{
    NSMutableArray *frameList = [[NSMutableArray alloc] initWithCapacity:50];
    
    numFrames = 0;
    for(;;)
    {
        NSString *frameName = [NSString stringWithFormat:frameNames, numFrames+1];
        BOOL isRetina = [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0);
        
        NSString *retinaExtension = @"";
        
        if (isRetina == YES)
        {
            retinaExtension = @"@2x";
        }
        
        if (self.animationFrameExtension != nil && [self.animationFrameExtension length] > 0)
        {
            frameName = [NSString stringWithFormat:@"%@%@.%@", frameName, retinaExtension, self.animationFrameExtension];
        }
        else
        {
            frameName = [NSString stringWithFormat:@"%@%@", frameName, retinaExtension];
        }
        
        NSObject *fr = [spriteData objectForKey:frameName];
        if(!fr)
        {
            break;
        }
        [frameList addObject:fr];
        numFrames++;
    }
    
    self.selectedFrames = frameList;
    
    // create the animation
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"frameIndex"];
    anim.fromValue = [NSNumber numberWithInt:0];
    anim.toValue = [NSNumber numberWithInt:frameList.count];
    anim.duration = [[NSNumber numberWithInt:frameList.count] floatValue] / frameRate;
    anim.repeatCount = repeatCount;
    anim.delegate = self;
    
    state = TPSPRITE_RUNNING;
    
    stillFrame = nil;
    
    currentAnimation = anim;
    
    [self removeAllAnimations];
    
    [self addAnimation:anim forKey:@"frameIndex"];
    self.speed = 1.0;
    self.timeOffset = 0.0;
}

- (void)display
{
    CAWSpriteData *tempData = nil;
    
    if (stillFrame)
    {
        tempData = stillFrame;
    }
    else
    {
        unsigned int currentFrameIndex = ((CAWSpriteCoreLayer *)[self presentationLayer]).frameIndex;
        
        // wrap around
        if(state == TPSPRITE_STOPPED)
        {
            if(showLastFrame)
            {
                // show last frame
                tempData = [_selectedFrames objectAtIndex:[_selectedFrames count]-1];
            }
            else
            {
                // show empty frame
                tempData = [[CAWSpriteData alloc] init];
                tempData.posX=0;
                tempData.posY=0;
                tempData.offsetY=0;
                tempData.offsetX=0;
                tempData.spriteWidth=0;
                tempData.spriteHeight=0;
            }
        }
        else
        {
            // simply display the frame
            tempData = [_selectedFrames objectAtIndex:currentFrameIndex];
        }
    }
    
    // determine scaling factor
    static float scale = -1.0;
    if(scale == -1.0)
    {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale == 2.0))
        {
            scale = 0.5;
        }
        else
        {
            scale = 1.0;
        }
    }
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithBool:YES]
                     forKey: kCATransactionDisableActions];
    self.position = CGPointMake(scale*(tempData.offsetX+tempData.spriteWidth/2.0), scale*(tempData.offsetY+tempData.spriteHeight/2.0));
    self.bounds = CGRectMake(tempData.offsetX*scale, tempData.offsetY*scale, tempData.spriteWidth*scale, tempData.spriteHeight*scale);
    self.contentsRect = CGRectMake(tempData.posX/atlasSize.width, tempData.posY/atlasSize.height, tempData.spriteWidth/atlasSize.width, tempData.spriteHeight/atlasSize.height);
    [CATransaction commit];
}

- (void) showFrame:(NSString *)frameName
{
    state = TPSPRITE_STOPPED;
    
    [self removeAllAnimations];
    stillFrame = [spriteData objectForKey:frameName];
    [self setNeedsDisplay];
}

- (void)pause
{
    if(state == TPSPRITE_RUNNING)
    {
        state = TPSPRITE_PAUSED;
        CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
        self.speed = 0.0;
        self.timeOffset = pausedTime;
    }
}

- (void)resume
{
    if(state == TPSPRITE_PAUSED)
    {
        state = TPSPRITE_RUNNING;
        CFTimeInterval pausedTime = [self timeOffset];
        self.speed = 1.0;
        self.timeOffset = 0.0;
        self.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.beginTime = timeSincePause;
    }
}

- (void)stop
{
    state = TPSPRITE_STOPPED;
    [self setNeedsDisplay];
    [self removeAllAnimations];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    if(![self animationForKey:@"frameIndex"])
    {
        state = TPSPRITE_STOPPED;
        [self setNeedsDisplay];
    }
}

#pragma clang diagnostic pop EVERY_WARNING

@end
