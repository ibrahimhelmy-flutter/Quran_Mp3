import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';


class MyAudio extends ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration totalDuration;
  Duration position;
  String audioState;

  MyAudio(){
    initAudio();
    notifyListeners();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updateDuration) {
      totalDuration = updateDuration;
      notifyListeners();
    });
    audioPlayer.onAudioPositionChanged.listen((updatePosition) {
      position = updatePosition;

      notifyListeners();
    });
    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == AudioPlayerState.STOPPED) audioState = "Stopped";
      if (playerState == AudioPlayerState.PLAYING) audioState = "Playing";
      if (playerState == AudioPlayerState.PAUSED) audioState = "Pause";
      if (playerState == AudioPlayerState.COMPLETED) audioState = "Completed";

      notifyListeners();
    });
  }

  playerAudio(String server, String SouraNum) {
    audioPlayer.play(server + "/$SouraNum.mp3");
    notifyListeners();

  }

  pauseAudio() {
    audioPlayer.pause();
notifyListeners();
  }

  stopAudio() {
    audioPlayer.stop();
    notifyListeners();
  }

  seekAudio(Duration durationToSeek){
    audioPlayer.seek(durationToSeek);
  }
}
