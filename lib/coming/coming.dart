import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class ComingPage extends StatefulWidget {
  const ComingPage({super.key});

  @override
  _ComingPageState createState() => _ComingPageState();
}

class _ComingPageState extends State<ComingPage> {
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  List<Event> _events = [];
  Map<DateTime, List<Event>> _groupedEvents = {};
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _errorMessage = '';
  String? _selectedCalendarId; // calendar ID

  @override
  void initState() {
    super.initState();
    _showCalendarPicker(); // Optionally call this method here to prompt at start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectedCalendarId != null
                  ? () => _retrieveEvents(_selectedDay)
                  : null,
              child: const Text('Load Events'),
            ),
            ElevatedButton(
              onPressed: _showCalendarPicker,
              child: const Text('Select Calendar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              eventLoader: (day) => _groupedEvents[day] ?? [],
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                if (_selectedCalendarId != null) {
                  _retrieveEvents(selectedDay);
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _groupedEvents[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_groupedEvents[_selectedDay]![index].title ??
                        'No Title'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCalendarPicker() async {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
      permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
        setState(() {
          _errorMessage = 'Permission to access the calendar was denied';
        });
        return;
      }
    }
    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    if (calendarsResult.isSuccess && calendarsResult.data != null) {
      final List<Calendar> calendars = calendarsResult.data!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select a Calendar'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: calendars.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(calendars[index].name ?? 'No Name'),
                    onTap: () {
                      setState(() {
                        _selectedCalendarId = calendars[index].id;
                        Navigator.of(context).pop();
                        _retrieveEvents(
                            _selectedDay); // Optionally load events immediately after selection
                      });
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      setState(() {
        _errorMessage = 'Failed to retrieve calendars';
      });
    }
  }

  Future<void> _retrieveEvents(DateTime day) async {
    if (_selectedCalendarId == null) {
      setState(() {
        _errorMessage = 'No calendar selected';
      });
      return;
    }
    try {
      final result = await _deviceCalendarPlugin.retrieveEvents(
        _selectedCalendarId!,
        RetrieveEventsParams(
            startDate: day, endDate: day.add(Duration(days: 1))),
      );
      if (result.isSuccess && result.data != null) {
        setState(() {
          _events = result.data!;
          _groupedEvents = _groupEvents(_events);
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to retrieve events';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error retrieving events: $e';
      });
    }
  }

  Map<DateTime, List<Event>> _groupEvents(List<Event> events) {
    Map<DateTime, List<Event>> data = {};
    for (var event in events) {
      DateTime date =
          DateTime.utc(event.start!.year, event.start!.month, event.start!.day);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    }
    return data;
  }
}
