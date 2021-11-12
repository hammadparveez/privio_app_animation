extension PlaybackDuration on Duration {
    String _twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
  String get  toPlayBackDuration {
    

    String twoDigitHours =
        _twoDigits(inHours.remainder(Duration.hoursPerDay));
    String twoDigitMinutes =
        _twoDigits(inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        _twoDigits(inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  String get playBackMintues {
      //4%60 = 4, 
    var mintues = inMinutes.remainder(Duration.minutesPerHour);
    var seconds = inSeconds.remainder(Duration.secondsPerMinute);
    
    return "$mintues:${_twoDigits(seconds)}";

  }
}
