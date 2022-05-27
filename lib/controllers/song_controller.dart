import 'package:audioplayers/audioplayers.dart';
import 'package:get/state_manager.dart';
import 'package:spotify_clone/models/song.dart';

class SongController extends GetxController {
  List<Song> _playlist = [];
  // Song? currentSong;
  int _index = 0;
  bool isPlaying = false;
  int position = 0; // in seconds
  int totalDuration = 1;

  Song? get currentSong => _index < _playlist.length ? _playlist[_index] : null;

  AudioPlayer? _player;
  AudioCache? _cache;

  @override
  void onReady() {
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((duration) {
      totalDuration = duration.inSeconds;
      update();
    });
    _player!.onAudioPositionChanged.listen((newPosition) {
      position = newPosition.inSeconds;
      update();
      if (position >= totalDuration) {
        // song ended
        nextSong();
      }
    });
  }

  @override
  void onClose() {
    _player!.dispose();
  }

  void selectSongInPlaylist(List<Song> playlist, int index) {
    assert(index < playlist.length);
    _playlist = playlist;
    _index = index;
    _cache!.play(currentSong!.mp3Path);
    isPlaying = true;
    update();
  }

  // void selectSong(int index) {
  //   assert(index < _playlist.length);
  //   _index = index;
  //   _cache!.play(currentSong!.mp3Path);
  //   isPlaying = true;
  //   update();
  // }

  void prevSong() {
    if (_index > 0) {
      _index--;
      position = 0;
      _cache!.play(currentSong!.mp3Path);
      isPlaying = true;
      update();
    }
  }

  void nextSong() {
    if (_index + 1 >= _playlist.length) {
      // reached end of playlist
      isPlaying = false;
      position = 0;
    } else {
      _index++;
      position = 0; // reset before playing next song
      _cache!.play(currentSong!.mp3Path);
      isPlaying = true;
    }
    update();
  }

  void addToQueue(Song song) {
    _playlist.add(song);
  }

  void playOrPause() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      _player!.resume();
    } else {
      _player!.pause();
    }
    update();
  }

  seek(int to) => _player!.seek(Duration(seconds: to));
}
