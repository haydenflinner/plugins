# Video Player plugin for Flutter

[![pub package](https://img.shields.io/pub/v/video_player.svg)](https://pub.dartlang.org/packages/video_player)

A Flutter plugin for iOS and Android for playing back video on a Widget surface.

![The example app running in iOS](https://github.com/flutter/plugins/blob/master/packages/video_player/doc/demo_ipod.gif?raw=true)

*Note*: This plugin is still under development, and some APIs might not be available yet.
[Feedback welcome](https://github.com/flutter/flutter/issues) and
[Pull Requests](https://github.com/flutter/plugins/pulls) are most welcome!

## Installation

First, add `video_player` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### iOS

Add the following entry to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

This entry allows your app to access video files by URL.

### Android

Ensure the following permission is present in your Android Manifest file, located in `<project root>/android/app/src/main/AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

The Flutter project template adds it, so it may already be there.

### Example

```dart
class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = new VideoPlayerController.network(
      'http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new AspectRatio(
            aspectRatio: 1280 / 720,
            child: new VideoPlayer(_controller),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed:
            _controller.value.isPlaying ? _controller.pause : _controller.play,
        child: new Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
```
