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

#import "CAWSpriteLayer.h"
#import "CAWSpriteCoreLayer.h"

@implementation CAWSpriteLayer

@synthesize animationLayer;

+ (id) layerWithSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img
{
    return [[CAWSpriteLayer alloc] initWithSpriteData:spriteData andImage:img];
}

- (id) initWithSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img
{
    if ( (self = [super init]) )
    {
        animationLayer = [CAWSpriteCoreLayer layer];
        [self addSublayer:animationLayer];
        [animationLayer setSpriteData:spriteData andImage:img];
    }
    return self;
}

- (void)setSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img
{
    [animationLayer setSpriteData:spriteData andImage:img];
}

- (void)playAnimation:(NSString*) frameNames withRate:(float)frameRate andRepeat:(float)repeatCount
{
    [animationLayer playAnimation:frameNames withRate:frameRate andRepeat:repeatCount];
}

- (void)playAnimation:(NSString*) frameNames withRate:(float)frameRate
{
    [animationLayer playAnimation:frameNames withRate:frameRate andRepeat:0];
}

- (void)showFrame:(NSString*)frameName
{
    [animationLayer showFrame:frameName];
}

- (void)pause
{
    [animationLayer pause];
}

- (void)resume
{
    [animationLayer resume];
}

- (void)stop
{
    [animationLayer stop];
}

- (void)setShowLastFrame:(bool)show
{
    [animationLayer setShowLastFrame:show];
}

- (void)setAnimationFrameExtension:(NSString *)frameExtension
{
    [animationLayer setAnimationFrameExtension:frameExtension];
}

@end

#pragma clang diagnostic pop EVERY_WARNING
