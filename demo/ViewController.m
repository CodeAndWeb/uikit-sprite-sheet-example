/**
 * View Controller
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
#import "ViewController.h"
#import "CAWSpriteReader.h"

@implementation ViewController

@synthesize btStop, btPause, btPlay;
@synthesize animationLayer;

- (void)viewDidLoad
{
    NSDictionary *spriteData = [CAWSpriteReader spritesWithContentOfFile:@"spritesheet.plist"];
    UIImage *texture = [UIImage imageNamed:@"spritesheet.png"];
    
    // animation
    animationLayer = [CAWSpriteLayer layerWithSpriteData:spriteData andImage:texture];
    [animationLayer setPosition:CGPointMake(self.animationView.frame.size.width/2,0)];
    animationLayer.frame = self.animationView.bounds;
    [self.animationView.layer addSublayer:animationLayer];
    [animationLayer playAnimation:@"CapGuyWalk%04d" withRate:24 andRepeat:9999];
    [animationLayer setShowLastFrame:true];
    
    // animation with transform: scaled layer
    CAWSpriteLayer *animationLayer2 = [CAWSpriteLayer layerWithSpriteData:spriteData andImage:texture];
    // scale the animation by 50%
    animationLayer2.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.0f);
    animationLayer2.frame = self.scaledAndTransformedView.bounds;
    [self.scaledAndTransformedView.layer addSublayer:animationLayer2];
    [animationLayer2 playAnimation:@"CapGuyWalk%04d" withRate:24  andRepeat:9999];
    [animationLayer2 setShowLastFrame:true];
    
    // static image
    CAWSpriteLayer *staticImageLayer = [CAWSpriteLayer layerWithSpriteData:spriteData andImage:texture];
    staticImageLayer.frame = self.staticView.bounds;
    [self.staticView.layer addSublayer:staticImageLayer];
    [staticImageLayer showFrame:@"Box2"];
}

- (float)scaleForSize:(CGSize)size toFitView:(UIView*)view
{
    CGSize viewSize = view.frame.size;
    float toScaleWidth = viewSize.width / size.width;
    float toScaleHeight = viewSize.height / size.height;
    return toScaleWidth < toScaleHeight ? toScaleWidth : toScaleHeight;
}

// Action methods for the test buttons (just to demonstrate the functionality)
- (IBAction)stop:(id)sender
{
    [animationLayer stop];
}

- (IBAction)play:(id)sender
{
    [animationLayer resume];
}

- (IBAction)pause:(id)sender
{
    [animationLayer pause];
}

- (IBAction)start:(id)sender
{
    [animationLayer playAnimation:@"CapGuyWalk%04d" withRate:24 andRepeat:INFINITY];
    [animationLayer setShowLastFrame:false];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
