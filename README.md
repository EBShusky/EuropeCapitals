# Europe Capitals

Developed using Xcode 12.2. No dependencies, simply open and run!

Pictures on a main screen list are not cached and are loaded each time list refreshes. There is a race when fast scrolling the main table view due to cell reuse and lack of proper network call handling. There is also no cache when applying filters, refreshing the content on the screen is done by another network call.

DI container implementation is dead simple.

Unit tests are written for some classes only.

Have Fun!
