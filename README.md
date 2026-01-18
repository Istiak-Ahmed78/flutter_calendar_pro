<table width="100%">
<tr>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 1. Basic Month View

<img src="https://github.com/user-attachments/assets/9cb83c72-8a07-4ad8-915b-d90b8c3326c9" alt="Basic Month View" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class BasicMonthViewExample extends StatelessWidget {
  const BasicMonthViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Month View'),
      ),
      body: AdvancedCalendar(
        controller: CalendarController(),
        onDaySelected: (selectedDay) {
          print('Selected day: $selectedDay');
        },
      ),
    );
  }
}
```

</div>

</details>

</div>
</td>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 2. Month View with Events

<img src="https://github.com/user-attachments/assets/e9d5a592-3a13-4b04-b479-ba8341a0fd5a" alt="Month View with Events" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class MonthViewWithEvents extends StatefulWidget {
  const MonthViewWithEvents({super.key});

  @override
  State<MonthViewWithEvents> createState() => _MonthViewWithEventsState();
}

class _MonthViewWithEventsState extends State<MonthViewWithEvents> {
  late CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();

    // Add sample events
    _controller.addEvent(
      CalendarEvent(
        id: '1',
        title: 'Team Meeting',
        startDate: DateTime.now().add(Duration(days: 1)),
        endDate: DateTime.now().add(Duration(days: 1, hours: 1)),
        color: Colors.blue,
      ),
    );
    
    _controller.addEvent(
      CalendarEvent(
        id: '2',
        title: 'Project Deadline',
        startDate: DateTime.now().add(Duration(days: 5)),
        endDate: DateTime.now().add(Duration(days: 5)),
        color: Colors.red,
        isAllDay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Month View with Events'),
      ),
      body: AdvancedCalendar(
        controller: _controller,
        onDaySelected: (selectedDay) {
          final events = _controller.getEventsForDay(selectedDay);
          print('Events on $selectedDay: ${events.length}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

</div>

</details>

</div>
</td>
</tr>
<tr>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 3. Week View

<img src="https://github.com/user-attachments/assets/d5195739-9145-4471-b15a-682c0ebec9b4" alt="Week View" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class WeekViewExample extends StatefulWidget {
  const WeekViewExample({super.key});

  @override
  State<WeekViewExample> createState() => _WeekViewExampleState();
}

class _WeekViewExampleState extends State<WeekViewExample> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController(
      initialView: CalendarView.week,
    );
    
    // Add sample events
    _controller.addEvent(
      CalendarEvent(
        id: '1',
        title: 'Morning Standup',
        startDate: DateTime.now().copyWith(hour: 9, minute: 0),
        endDate: DateTime.now().copyWith(hour: 9, minute: 30),
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => _controller.goToToday(),
          ),
        ],
      ),
      body: AdvancedCalendar(
        controller: _controller,
        config: CalendarConfig(
          initialView: CalendarView.week,
          timeSlotHeight: 60,
          showTimeIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

</div>

</details>

</div>
</td>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 4. Day View

<img src="https://github.com/user-attachments/assets/985e2c06-5ae6-4a3c-9d8e-c8a1f2e8ac41" alt="Day View" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class DayViewExample extends StatefulWidget {
  const DayViewExample({super.key});

  @override
  State<DayViewExample> createState() => _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController(
      initialView: CalendarView.day,
    );
    
    final today = DateTime.now();
    _controller.addEvent(
      CalendarEvent(
        id: '1',
        title: 'Team Standup',
        startDate: today.copyWith(hour: 9, minute: 0),
        endDate: today.copyWith(hour: 9, minute: 30),
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day View'),
      ),
      body: AdvancedCalendar(
        controller: _controller,
        config: CalendarConfig(
          initialView: CalendarView.day,
          timeSlotHeight: 80,
          showTimeIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

</div>

</details>

</div>
</td>
</tr>
<tr>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 5. Agenda View

<img src="https://github.com/user-attachments/assets/8a3d9f68-fd67-43a3-ad86-cc34256397c1" alt="Agenda View" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class AgendaViewExample extends StatefulWidget {
  const AgendaViewExample({super.key});

  @override
  State<AgendaViewExample> createState() => _AgendaViewExampleState();
}

class _AgendaViewExampleState extends State<AgendaViewExample> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController(
      initialView: CalendarView.agenda,
    );
    
    final now = DateTime.now();
    _controller.addEvent(
      CalendarEvent(
        id: '1',
        title: 'Project Kickoff',
        startDate: now,
        endDate: now.add(const Duration(hours: 2)),
        color: Colors.blue,
        description: 'Initial project planning meeting',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda View'),
      ),
      body: AdvancedCalendar(
        controller: _controller,
        config: CalendarConfig(
          initialView: CalendarView.agenda,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

</div>

</details>

</div>
</td>
<td width="50%" valign="top" align="center" style="padding: 0 40px;">
<div style="max-width: 400px; margin: 0 auto;">

### 6. Timeline View

<img src="https://github.com/user-attachments/assets/54dab143-326b-4a58-b9d2-b9241cc5aa51" alt="Timeline View" width="300" />

<details>
<summary><b>📝 Show Code</b></summary>

<div align="left">

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_pro/flutter_calendar_pro.dart';

class TimelineViewExample extends StatefulWidget {
  const TimelineViewExample({super.key});

  @override
  State<TimelineViewExample> createState() => _TimelineViewExampleState();
}

class _TimelineViewExampleState extends State<TimelineViewExample> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController(
      initialView: CalendarView.timeline,
    );
    
    final today = DateTime.now();
    _controller.addEvent(
      CalendarEvent(
        id: '1',
        title: 'Board Meeting',
        startDate: today.copyWith(hour: 9, minute: 0),
        endDate: today.copyWith(hour: 11, minute: 0),
        color: Colors.blue,
        resourceId: 'room_a',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline View'),
      ),
      body: AdvancedCalendar(
        controller: _controller,
        config: CalendarConfig(
          initialView: CalendarView.timeline,
          resources: [
            Resource(
              id: 'room_a',
              name: 'Conference Room A',
              color: Colors.blue.shade100,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

</div>

</details>

</div>
</td>
</tr>
</table>
