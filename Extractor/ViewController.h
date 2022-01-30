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

@property (weak) IBOutlet NSTextView *textOutput;
@property (weak) IBOutlet NSTextField *textInputFile;
@property (weak) IBOutlet NSTextField *textOutputDirectory;

int cli_main(int argc, char * argv[]);

@end

