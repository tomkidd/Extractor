//
//  ViewController.h
//  Extractor
//
//  Created by Tom Kidd on 1/21/22.
//

#import <Cocoa/Cocoa.h>
#include <iostream>
#include <sstream>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSButton *extractButton;
@property (unsafe_unretained) IBOutlet NSTextView *textOutput;

int cli_main(int argc, char * argv[]);

@end

