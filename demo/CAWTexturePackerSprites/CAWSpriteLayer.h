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

#import <Foundation/Foundation.h>

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

@interface CAWSpriteLayer : CALayer

@property (nonatomic, strong) CAWSpriteCoreLayer *animationLayer;

/**
 * Create new layer with given sprite data and image
 * @param spriteData sprite data array, load with CAWSpriteReader
 * @param img the sprite sheet image
 */
+ (id) layerWithSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img;

/**
 * Initialize layer with given sprite data and image
 * @param spriteData sprite data array, load with CAWSpriteReader
 * @param img the sprite sheet image
 */
- (id) initWithSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img;

/**
 * Set new sprite data
 * @param spriteData sprite data array, load with CAWSpriteReader
 * @param img the sprite sheet image
 */
- (void)setSpriteData:(NSDictionary *)spriteData andImage:(UIImage*)img;

/**
 * Play animation with given frame rate and repeat.
 * The function selects all frames that match the name and creates an animation.
 * @param frameNames with %d placeholder - e.g. frame_%04d
 * @param frameRate rate to play the animation
 * @param repeatCount number of repetitions
 */
- (void)playAnimation:(NSString*) frameNames withRate:(float)frameRate andRepeat:(float)repeatCount;

/**
 * Play animation once with given framerate.
 * The function selects all frames that match the name and creates an animation.
 * @param frameNames with %d placeholder - e.g. frame_%04d
 * @param frameRate rate to play the animation
 */
- (void)playAnimation:(NSString*) frameNames withRate:(float)frameRate;

/**
 * Show the frame with the given name as still frame
 * @param frameName name of the frame
 */
- (void)showFrame:(NSString*)frameName;

/**
 * Pause animation
 */
- (void)pause;

/**
 * Resume animation
 */

- (void)resume;

/**
 * Stop animation, remove it from display
 */
- (void)stop;

/**
 * Set behavior after animation is ended: Show last frame
 * or show empty frame
 * @param show shows last frame if true
 */
- (void)setShowLastFrame:(bool)show;

- (void)setAnimationFrameExtension:(NSString *)frameExtension;

@end

#pragma clang diagnostic pop EVERY_WARNING
