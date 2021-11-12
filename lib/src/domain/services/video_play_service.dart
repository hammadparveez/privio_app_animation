import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:privio/src/shared/extensions.dart';

class VideoPlayService extends ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  bool _isFullScreen = false;
  bool _isOptionVisible = false;
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  Future<VideoPlayerController> initVideo(String assetPath) async {
    _videoPlayerController = VideoPlayerController.asset(assetPath);
    try {
      await _videoPlayerController.initialize();
      notifyListeners();
    } catch (e) {
      print("Error Occured during Video init $e");
    }
    return _videoPlayerController;
  }
  
  void playOrPause() async {
    _videoPlayerController.value.isPlaying
        ? _videoPlayerController.pause()
        : _videoPlayerController.play();
    notifyListeners();
  }

  void mute() {
    isMute
        ? videoPlayerController.setVolume(1)
        : videoPlayerController.setVolume(0);
    notifyListeners();
  }

  void setVolume(double volume) {
    videoPlayerController.setVolume(volume);
    notifyListeners();
  }

  void move(Duration time) {
    videoPlayerController.seekTo(time);
    notifyListeners();
  }

  void rotate() {
    if (_isFullScreen) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
    _isFullScreen = !_isFullScreen;
    if (isPlaying) {
      _isOptionVisible = !_isOptionVisible;
    }
    notifyListeners();
  }

  void hideOptions() {
    _isOptionVisible = !_isOptionVisible;
    notifyListeners();
  }

  bool get isInitialized => videoPlayerController.value.isInitialized;
  bool get isOptionVisible => _isOptionVisible;
  String get watchedDuration =>
      videoPlayerController.value.position.toPlayBackDuration;

  String get totalDuration =>
      videoPlayerController.value.duration.toPlayBackDuration;

  bool get isPlaying => videoPlayerController.value.isPlaying;
  bool get isMute => videoPlayerController.value.volume == 0.0;
  bool get isNormal => videoPlayerController.value.volume <= 0.5;

  bool get isHigh => videoPlayerController.value.volume <= 1.0;

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
