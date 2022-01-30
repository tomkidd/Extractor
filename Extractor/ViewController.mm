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

- (IBAction)extract:(NSButton *)sender {
//    NSLog(@"hi");

    // Calling the process_file util method:

//    ::extract_options o;
//    std::string file = "/Users/tomkidd/Downloads/setup_the_ultimate_doom_1.9_(28044).exe";
//    o.warn_unused = true;
//    o.list = true;
//    o.list_sizes = true;
//    o.preserve_file_times = true;
//    o.gog_galaxy = true; //???
//    o.extract_unknown = true;
//    o.extract_temp = true;
//
//
//    process_file(file, o);
    
    
    // Simulating the CLI:
    // innoextract -l /Users/tomkidd/Downloads/setup_the_ultimate_doom_1.9_(28044).exe

//    char* arguments[] =
//    {
//        (char*)("innoextract"),
//        (char*)("-l"),
//        (char*)("/Users/tomkidd/Downloads/setup_the_ultimate_doom_1.9_(28044).exe")
//    };
//
//    cli_main(3, arguments);
    
    NSString *s1 = @"innoextract";
    NSString *s2 = @"-l";
    NSString *s3 = @"/Users/tomkidd/Downloads/setup_the_ultimate_doom_1.9_(28044).exe";

    NSArray *array = [NSArray arrayWithObjects: s1, s2, s3, nil];
    
    std::ostringstream local;
    
    auto cout_buff = std::cout.rdbuf(); // save pointer to std::cout buffer
     
    std::cout.rdbuf(local.rdbuf()); // substitute internal std::cout buffer with
                                    // buffer of 'local' object

    // now std::cout work with 'local' buffer
    // you don't see this message
//    std::cout << "some message";
    cli_main(3, cArrayFromNSArray(array));

    // go back to old buffer
    std::cout.rdbuf(cout_buff);

    // you will see this message
    std::cout << "back to default buffer\n";

    // print 'local' content
    std::cout << "local content: " << local.str() << "\n";
    
    std::string test = local.str();

    [_textOutput setString:[NSString stringWithCString:test.c_str() encoding:NSUTF8StringEncoding]];
    
    
}

char ** cArrayFromNSArray ( NSArray* array ){
   int i, count = array.count;
   char **cargs = (char**) malloc(sizeof(char*) * (count + 1));
   for(i = 0; i < count; i++) {        //cargs is a pointer to 4 pointers to char
      NSString *s      = array[i];     //get a NSString
      const char *cstr = s.UTF8String; //get cstring
      int          len = strlen(cstr); //get its length
      char  *cstr_copy = (char*) malloc(sizeof(char) * (len + 1));//allocate memory, + 1 for ending '\0'
      strcpy(cstr_copy, cstr);         //make a copy
      cargs[i] = cstr_copy;            //put the point in cargs
  }
  cargs[i] = NULL;
  return cargs;
}



@end
