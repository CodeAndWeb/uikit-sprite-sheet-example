# TexturePacker UIKit Demo


This demonstration explains how TexturePacker can be used to create SpriteSheets for UIKit projects. The classes contained in this project allow you to easily play animations and display single frames.

See http://www.codeandweb.com/texturepacker/tutorials/uikit-animations-with-texturepacker

## Creating the sprite sheets

Use TexturePacker to create the sprite sheet - use the "UIKit (Plist)" - exporter


## Using the sprite sheet

### Loading data

Load the created .plist data file:

    NSDictionary *spriteData = [CAWSpriteReader spritesWithContentOfFile:@"spritesheet.plist"];

Load the image:
    
    UIImage *texture = [UIImage imageNamed:@"spritesheet.png"];
    
Create an animation layer:

	// create the layer
    CAWSpriteLayer *animationLayer = [CAWSpriteLayer layerWithSpriteData:spriteData andImage:texture];

	// add it to the current view
    [self.view.layer addSublayer:animationLayer];
        
    // start playing an animation (CapGuyWalk0000, CapGuyWalk0001,….)
    // repeat animation 
    // framerate is 24 fps
    [animationLayer playAnimation:@"CapGuyWalk%04d" withRate:24 andRepeat:INFINITY];

	// set the position 
    [animationLayer setPosition:CGPointMake(50, 80)];

Play animation, stop after first play and hide animation

	// play once
	[animationLayer playAnimation:@"CapGuyWalk%04d" withRate:24];

	// keep last frame after animation is over
    [animationLayer setShowLastFrame:true];

Apply transformations (e.g. scaling)
    
    animationLayer.transform = CATransform3DMakeScale(0.5,0.5, 1.0);

Stop, play, resume:

    [animationLayer pause];
    [animationLayer resume];
    [animationLayer stop];
    
Display single frame:

	// create layer
	CAWSpriteLayer *staticImageLayer = [CAWSpriteLayer layerWithSpriteData:spriteData andImage:texture];
	
	// add to view
    [self.view.layer addSublayer:staticImageLayer];
        
    // set position
    [staticImageLayer setPosition:CGPointMake(400, 200)];
    
    // set frame to display
    [staticImageLayer showFrame:@"Box2"];    
    