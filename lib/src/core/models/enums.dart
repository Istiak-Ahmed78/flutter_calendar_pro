/// Event priority levels
enum EventPriority {
  low,
  normal,
  high,
  urgent,
}

/// Event status
enum EventStatus {
  confirmed,
  tentative,
  cancelled,
}

/// Calendar view types
enum CalendarView {
  month,
  week,
  day,
  year,
  agenda,
  timeline,
}

/// Recurrence frequency
enum RecurrenceFrequency {
  daily,
  weekly,
  monthly,
  yearly,
}

/// Recurrence end type
enum RecurrenceEndType {
  never,
  until,
  count,
}

/// Week start day
enum WeekStartDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekStartDayExtension on WeekStartDay {
  int get value {
    switch (this) {
      case WeekStartDay.monday:
        return DateTime.monday;
      case WeekStartDay.tuesday:
        return DateTime.tuesday;
      case WeekStartDay.wednesday:
        return DateTime.wednesday;
      case WeekStartDay.thursday:
        return DateTime.thursday;
      case WeekStartDay.friday:
        return DateTime.friday;
      case WeekStartDay.saturday:
        return DateTime.saturday;
      case WeekStartDay.sunday:
        return DateTime.sunday;
    }
  }
}
