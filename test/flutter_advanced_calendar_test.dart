import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  group('Package Exports Test', () {
    test('CalendarEvent can be created', () {
      final event = CalendarEvent(
        id: '1',
        title: 'Test Event',
        startDate: DateTime(2024, 1, 15, 10, 0),
        endDate: DateTime(2024, 1, 15, 11, 0),
        color: Colors.blue,
      );

      expect(event.id, '1');
      expect(event.title, 'Test Event');
      expect(event.color, Colors.blue);
    });

    test('CalendarController can be created', () {
      final controller = CalendarController();
      expect(controller.focusedDay, isNotNull);
      expect(controller.currentView, CalendarView.month);
      controller.dispose();
    });

    test('CalendarConfig can be created', () {
      const config = CalendarConfig(
        initialView: CalendarView.week,
        showWeekNumbers: true,
      );

      expect(config.initialView, CalendarView.week);
      expect(config.showWeekNumbers, true);
    });

    test('RecurrenceRule can be created', () {
      final rule = RecurrenceRule(
        frequency: RecurrenceFrequency.daily,
        interval: 1,
      );

      expect(rule.frequency, RecurrenceFrequency.daily);
      expect(rule.interval, 1);
    });

    test('Enums are accessible', () {
      expect(EventPriority.high, isNotNull);
      expect(EventStatus.confirmed, isNotNull);
      expect(CalendarView.month, isNotNull);
      expect(RecurrenceFrequency.weekly, isNotNull);
      expect(WeekStartDay.monday, isNotNull);
    });
  });
}
