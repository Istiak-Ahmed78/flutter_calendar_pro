import 'package:flutter/material.dart';
import 'enums.dart';
import 'recurrence_rule.dart';
import '../utils/date_utils.dart' as calendar_utils;

/// Calendar event model with full feature support
class CalendarEvent {
  final String id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDay;

  // Individual event colors
  final Color color;
  final Color? textColor;
  final Color? dotColor; // NEW: Individual dot color for event indicators

  // Range events (today + N days)
  final int? durationDays;

  // Metadata
  final String? location;
  final IconData? icon;
  final String? category;
  final EventPriority priority;
  final EventStatus status;

  // Recurrence
  final RecurrenceRule? recurrenceRule;
  final List<DateTime>? exceptionDates;

  // Day counter (Day 3/7)
  final int? currentDay;
  final int? totalDays;

  // Custom data
  final Map<String, dynamic>? customData;

  CalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.isAllDay = false,
    this.color = Colors.blue,
    this.textColor,
    this.dotColor, // NEW
    this.durationDays,
    this.location,
    this.icon,
    this.category,
    this.priority = EventPriority.normal,
    this.status = EventStatus.confirmed,
    this.recurrenceRule,
    this.exceptionDates,
    this.currentDay,
    this.totalDays,
    this.customData,
  }) : assert(
          !endDate.isBefore(startDate),
          'End date must be after or equal to start date',
        );

  /// Create range event (today + N days)
  factory CalendarEvent.withDuration({
    required String id,
    required String title,
    required DateTime startDate,
    required int durationDays,
    String? description,
    Color color = Colors.blue,
    Color? textColor,
    Color? dotColor, // NEW
    String? location,
    IconData? icon,
    String? category,
    EventPriority priority = EventPriority.normal,
    EventStatus status = EventStatus.confirmed,
    Map<String, dynamic>? customData,
  }) {
    return CalendarEvent(
      id: id,
      title: title,
      description: description,
      startDate: startDate,
      endDate: startDate.add(Duration(days: durationDays)),
      durationDays: durationDays,
      color: color,
      textColor: textColor,
      dotColor: dotColor, // NEW
      isAllDay: true,
      location: location,
      icon: icon,
      category: category,
      priority: priority,
      status: status,
      customData: customData,
    );
  }

  /// Get the effective dot color (uses dotColor if set, otherwise uses event color)
  Color get effectiveDotColor => dotColor ?? color;

  /// Check if event spans multiple days
  bool get isMultiDay =>
      !calendar_utils.isSameDay(startDate, endDate) && isAllDay;

  /// Get all dates this event covers
  List<DateTime> get dateRange =>
      calendar_utils.getDateRange(startDate, endDate);

  /// Calculate current day in multi-day event
  int? getCurrentDay(DateTime date) {
    if (!isMultiDay) return null;

    final index =
        dateRange.indexWhere((d) => calendar_utils.isSameDay(d, date));

    return index >= 0 ? index + 1 : null;
  }

  /// Get total days in multi-day event
  int get getTotalDays => isMultiDay ? dateRange.length : 1;

  /// Check if event occurs on a specific date
  bool occursOnDate(DateTime date) {
    if (exceptionDates?.any(
          (e) => calendar_utils.isSameDay(e, date),
        ) ==
        true) {
      return false;
    }

    if (dateRange.any((d) => calendar_utils.isSameDay(d, date))) {
      return true;
    }

    if (recurrenceRule != null) {
      final occurrences = recurrenceRule!.generateOccurrences(
        startDate,
        date,
        date.add(const Duration(days: 1)),
      );
      return occurrences.isNotEmpty;
    }

    return false;
  }

  /// Duration helpers
  double get durationInHours => endDate.difference(startDate).inMinutes / 60.0;

  int get durationInMinutes => endDate.difference(startDate).inMinutes;

  bool get isHappening {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  bool get isPast => endDate.isBefore(DateTime.now());

  bool get isFuture => startDate.isAfter(DateTime.now());

  bool get isCancelled => status == EventStatus.cancelled;

  bool get isTentative => status == EventStatus.tentative;

  /// Copy with
  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDay,
    Color? color,
    Color? textColor,
    Color? dotColor, // NEW
    int? durationDays,
    String? location,
    IconData? icon,
    String? category,
    EventPriority? priority,
    EventStatus? status,
    RecurrenceRule? recurrenceRule,
    List<DateTime>? exceptionDates,
    int? currentDay,
    int? totalDays,
    Map<String, dynamic>? customData,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDay: isAllDay ?? this.isAllDay,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      dotColor: dotColor ?? this.dotColor, // NEW
      durationDays: durationDays ?? this.durationDays,
      location: location ?? this.location,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      exceptionDates: exceptionDates ?? this.exceptionDates,
      currentDay: currentDay ?? this.currentDay,
      totalDays: totalDays ?? this.totalDays,
      customData: customData ?? this.customData,
    );
  }

  /// Convert to JSON (NO deprecated APIs)
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'isAllDay': isAllDay,
        'color': color.toARGB32(),
        'textColor': textColor?.toARGB32(),
        'dotColor': dotColor?.toARGB32(), // NEW
        'durationDays': durationDays,
        'location': location,
        'category': category,
        'priority': priority.name,
        'status': status.name,
        'recurrenceRule': recurrenceRule?.toJson(),
        'exceptionDates':
            exceptionDates?.map((d) => d.toIso8601String()).toList(),
        'currentDay': currentDay,
        'totalDays': totalDays,
        'customData': customData,
      };

  /// Create from JSON (safe + backward compatible)
  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    int readColor(dynamic raw, int fallback) {
      if (raw is int) return raw;
      if (raw is String) return int.tryParse(raw) ?? fallback;
      return fallback;
    }

    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isAllDay: json['isAllDay'] ?? false,
      color: Color(
        readColor(json['color'], Colors.blue.toARGB32()),
      ),
      textColor: json['textColor'] != null
          ? Color(
              readColor(
                json['textColor'],
                Colors.transparent.toARGB32(),
              ),
            )
          : null,
      dotColor: json['dotColor'] != null // NEW
          ? Color(
              readColor(
                json['dotColor'],
                Colors.transparent.toARGB32(),
              ),
            )
          : null,
      durationDays: json['durationDays'],
      location: json['location'],
      category: json['category'],
      priority: EventPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => EventPriority.normal,
      ),
      status: EventStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => EventStatus.confirmed,
      ),
      recurrenceRule: json['recurrenceRule'] != null
          ? RecurrenceRule.fromJson(json['recurrenceRule'])
          : null,
      exceptionDates: json['exceptionDates'] != null
          ? (json['exceptionDates'] as List)
              .map((d) => DateTime.parse(d))
              .toList()
          : null,
      currentDay: json['currentDay'],
      totalDays: json['totalDays'],
      customData: json['customData'],
    );
  }

  @override
  String toString() =>
      'CalendarEvent(id: $id, title: $title, start: $startDate, end: $endDate)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CalendarEvent && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
