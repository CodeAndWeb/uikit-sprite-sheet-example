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

#import <QuartzCore/QuartzCore.h>

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

#import "CAWSpriteData.h"

typedef enum
{
    TPSPRITE_INIT,
    TPSPRITE_RUNNING,
    TPSPRITE_STOPPED,
    TPSPRITE_PAUSED,
} CAWSpriteState;

@interface CAWSpriteCoreLayer : CALayer
{
    unsigned int frameIndex;
    bool showLastFrame;
    NSString *animationFrameExtension;
    CAWSpriteState state;
    int showFrame;
    CAWSpriteData *stillFrame;
    CABasicAnimation *currentAnimation;
}
@property (nonatomic,readwrite) unsigned int frameIndex;
@property (nonatomic, assign) CGSize atlasSize;
@property (nonatomic, assign) int numFrames;
@property (nonatomic, strong) NSDictionary *spriteData;
@property (nonatomic, strong) NSMutableArray *selectedFrames;
@property (nonatomic, strong) CALayer *subLayer;
@property (nonatomic, strong) CAWSpriteData *stillFrame;
@property (nonatomic, assign) bool showLastFrame;
@property (nonatomic, copy) NSString *animationFrameExtension;

- (void) playAnimation:(NSString*) frameNames withRate:(float)frameRate andRepeat:(float)repeatCount;

/**
 Show single Frame without Animation
 */
- (void) showFrame:(NSString*)frameName;

/**
 * Pause the animation
 */
- (void)pause;

/**
 * Resume animation
 */
- (void)resume;

/**
 * Stop animation
 */
- (void)stop;

- (void)setSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img;

#pragma clang diagnostic pop EVERY_WARNING

@end

