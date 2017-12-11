#  WebDGram - Simple Instagram Clone

This was a small project used to introduce several iOS concepts at a time such as Auto Layout, scroll views, gesture recognizers and more.


## Build Instructions
You'll need to set up a project in Firebase. This is the app's only data source. First install the Firebase SDK with cocoapods by running the following commands:

    $ pod install
    $ open WebDGram.xcworkspace

Download a GoogleService-Info.plist file from Firebase console and include it in the app.


## Known Issues
* This app does nothing to optimize the size of your images so the smaller the better.
* It doesn't play to nice with images that aren't square.
* Liking posts won't work (double-tap).
* The timestamp also doesn't work.
* For some reason refreshing the posts doesn't work. Also working on that. Restart the app to see you new post.
