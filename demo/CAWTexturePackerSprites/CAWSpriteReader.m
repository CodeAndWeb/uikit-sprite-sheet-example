/**
 * CodeAndWeb SpriteReader
 *
 * Reads animation frames from TexturePacker's Generic XML format
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

#import "CAWSpriteReader.h"
#import "CAWSpriteData.h"

@implementation CAWSpriteReader

+ (NSDictionary *)spritesWithContentOfFile:(NSString *)filename
{
    // split file name
    NSString* file = [[filename lastPathComponent] stringByDeletingPathExtension];
	NSString* extension = [filename pathExtension];
    
    // check if the filename contained a path
    int nameLength = file.length + extension.length + 1;
    if(nameLength < filename.length) {
        file = [NSString stringWithFormat:@"%@%@",
                [filename substringToIndex:filename.length - nameLength],
                file];
    }

    // check if we need to load the @2x file
	if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
		([UIScreen mainScreen].scale == 2.0))
	{
		file = [NSString stringWithFormat:@"%@@2x", file];
	}
    
    // read the data from the plist file
	NSDictionary* xmlDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:extension]];

    // target dictionary containing the TPSpriteData objects
	NSMutableDictionary* tpDict = [[NSMutableDictionary alloc] init];
    
    // extract frames
	NSDictionary* frames = [xmlDictionary objectForKey:@"frames"];

	for (NSString* name in [frames allKeys])
	{
        NSDictionary *sprite = [frames objectForKey:name];

        // create the frame object
        CAWSpriteData *temp = [[CAWSpriteData alloc] init];
        [temp setPosX:[[sprite objectForKey:@"x"] integerValue]];
        [temp setPosY:[[sprite objectForKey:@"y"] integerValue]];
        [temp setSpriteWidth:[[sprite objectForKey:@"w"] integerValue]];
        [temp setSpriteHeight:[[sprite objectForKey:@"h"] integerValue]];

        // get the offset if sprite is trimmed
        NSString *oXString = [sprite objectForKey:@"oX"];
        NSString *oYString = [sprite objectForKey:@"oY"];        
        [temp setOffsetX:oXString ? [oXString integerValue] : 0];
        [temp setOffsetY:oYString ? [oYString integerValue] : 0];
        
        // add frame to data
        [tpDict setObject:temp forKey:name];
	}
    return tpDict;
}

@end
