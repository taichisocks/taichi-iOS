//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <sqlite3.h>
void startProxyWithConfig(const char* remoteHost, int remotePort, const char* method, const char* password, const char* localHost, int localPort);