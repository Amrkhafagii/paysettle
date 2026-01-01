enum InsightsRange { days7, days30, days90, days365 }

extension InsightsRangeX on InsightsRange {
  String get label {
    switch (this) {
      case InsightsRange.days7:
        return '7d';
      case InsightsRange.days30:
        return '30d';
      case InsightsRange.days90:
        return '90d';
      case InsightsRange.days365:
        return '365d';
    }
  }

  String get rpcValue {
    switch (this) {
      case InsightsRange.days7:
        return '7d';
      case InsightsRange.days30:
        return '30d';
      case InsightsRange.days90:
        return '90d';
      case InsightsRange.days365:
        return '365d';
    }
  }
}
