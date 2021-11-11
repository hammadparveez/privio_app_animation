extension PlaybackDuration on Duration {
  String get  toPlayBackDuration {
      String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours =
        twoDigits(inHours.remainder(Duration.hoursPerDay));
    String twoDigitMinutes =
        twoDigits(inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        twoDigits(inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
