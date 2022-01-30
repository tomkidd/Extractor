//
//  ViewController.m
//  Extractor
//
//  Created by Tom Kidd on 1/21/22.
//

#import "ViewController.h"
#include "cli/extract.hpp"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)listFiles:(NSButton *)sender {

    if ([[_textInputFile stringValue] length] == 0) {
        NSAlert *alert = [NSAlert new];
        [alert setMessageText:@"You must select an input file"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        return;
    }
    
    NSArray *array = [NSArray arrayWithObjects: @"innoextract", @"-l", [_textInputFile stringValue], nil];
    
    std::ostringstream local;
    
    auto cout_buff = std::cout.rdbuf(); // save pointer to std::cout buffer
     
    std::cout.rdbuf(local.rdbuf()); // substitute internal std::cout buffer with
                                    // buffer of 'local' object

    // now std::cout work with 'local' buffer
    cli_main(3, cArrayFromNSArray(array));

    // go back to old buffer
    std::cout.rdbuf(cout_buff);
    
    [_textOutput setString:[NSString stringWithCString:local.str().c_str() encoding:NSUTF8StringEncoding]];
    [_textOutput scrollToEndOfDocument:self];
}

- (IBAction)extractFiles:(NSButton *)sender {
    
    if ([[_textInputFile stringValue] length] == 0) {
        NSAlert *alert = [NSAlert new];
        [alert setMessageText:@"You must select an input file"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        return;
    }
    
    if ([[_textOutputDirectory stringValue] length] == 0) {
        NSAlert *alert = [NSAlert new];
        [alert setMessageText:@"You must select an output directory"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager new];
    BOOL isDir;
    BOOL exists = [fileManager fileExistsAtPath:[_textOutputDirectory stringValue] isDirectory:&isDir];
    
    if (!exists) {
        NSAlert *alert = [NSAlert new];
        [alert setMessageText:@"Output path does not exist"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        return;
    }
    
    if (!isDir) {
        NSAlert *alert = [NSAlert new];
        [alert setMessageText:@"Output path is not a directory"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        return;
    }
    

    NSArray *array = [NSArray arrayWithObjects: @"innoextract", [_textInputFile stringValue], @"-d", [_textOutputDirectory stringValue], nil];
    
    std::ostringstream local;
    
    auto cout_buff = std::cout.rdbuf(); // save pointer to std::cout buffer
     
    std::cout.rdbuf(local.rdbuf()); // substitute internal std::cout buffer with
                                    // buffer of 'local' object

    // now std::cout work with 'local' buffer
    cli_main(4, cArrayFromNSArray(array));

    // go back to old buffer
    std::cout.rdbuf(cout_buff);
    
    [_textOutput setString:[NSString stringWithCString:local.str().c_str() encoding:NSUTF8StringEncoding]];
    [_textOutput scrollToEndOfDocument:self];
}

- (IBAction)chooseInputFile:(NSButton *)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    NSArray* fileTypes = [NSArray arrayWithObjects:@"exe", @"EXE", nil];
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowsMultipleSelection:NO];
    [openDlg setCanChooseDirectories:NO];
    [openDlg setAllowedFileTypes:fileTypes];
    if ( [openDlg runModal] == NSModalResponseOK )
    {
        NSArray* urls = [openDlg URLs];
        for(int i = 0; i < [urls count]; i++ )
        {
            NSString* url = [[urls objectAtIndex:i] path];
            [_textInputFile setStringValue:url];
        }
    }
}

- (IBAction)chooseOutputDirectory:(NSButton *)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:NO];
    [openDlg setAllowsMultipleSelection:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setCanCreateDirectories:YES];
    if ( [openDlg runModal] == NSModalResponseOK )
    {
        NSArray* urls = [openDlg URLs];
        for(int i = 0; i < [urls count]; i++ )
        {
            NSString* url = [[urls objectAtIndex:i] path];
            [_textOutputDirectory setStringValue:url];
        }
    }

}

char ** cArrayFromNSArray ( NSArray* array ){
   int i, count = (int)array.count;
   char **cargs = (char**) malloc(sizeof(char*) * (count + 1));
   for(i = 0; i < count; i++) {        //cargs is a pointer to 4 pointers to char
      NSString *s      = array[i];     //get a NSString
      const char *cstr = s.UTF8String; //get cstring
      int          len = (int)strlen(cstr); //get its length
      char  *cstr_copy = (char*) malloc(sizeof(char) * (len + 1));//allocate memory, + 1 for ending '\0'
      strcpy(cstr_copy, cstr);         //make a copy
      cargs[i] = cstr_copy;            //put the point in cargs
  }
  cargs[i] = NULL;
  return cargs;
}



@end
