enum SoccerFixtureStatus {
  scheduled,
  live,
  ended;

  bool get isLive => this == SoccerFixtureStatus.live;
  bool get isEnded => this == SoccerFixtureStatus.ended;
  bool get isScheduled => this == SoccerFixtureStatus.scheduled;
}
