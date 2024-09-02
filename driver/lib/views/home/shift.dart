import 'dart:collection';

import 'package:driver/helpers/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShiftState();
}

class ShiftState extends State<ShiftView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const ColoredBox(
              color: Colors.black,
              child: TabBar(
                indicatorPadding: EdgeInsets.only(bottom: 10),
                indicatorColor: Colors.pinkAccent,
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    text: "Shifts",
                  ),
                  Tab(
                    text: "Calendrier",
                  ),
                  Tab(
                    text: "Indisponibilité",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(color: Colors.blue),
                  Column(
                    children: [
                      TableCalendar(
                        headerStyle: HeaderStyle(
                            titleTextStyle:
                                Theme.of(context).textTheme.headlineMedium!,
                            headerPadding: const EdgeInsets.all(20),
                            formatButtonShowsNext: false,
                            leftChevronVisible: false,
                            rightChevronVisible: false),
                        eventLoader: (day) {
                          return _getEventsForDay(day);
                        },
                        locale: 'fr-FR',
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Mois'
                        },
                        calendarStyle: CalendarStyle(
                            todayTextStyle: const TextStyle(color: Colors.pink),
                            todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border:
                                    Border.all(width: 2, color: Colors.pink)),
                            selectedDecoration: BoxDecoration(
                                color: Colors.pink.shade300,
                                shape: BoxShape.circle),
                            markerDecoration: const BoxDecoration(
                                color: Color(0xff679fa3),
                                shape: BoxShape.circle)),
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });

                            _selectedEvents.value =
                                _getEventsForDay(selectedDay);
                          }
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                      Expanded(
                        child: ColoredBox(
                          color: Colors.black,
                          child: Stack(
                            children: [
                              ValueListenableBuilder<List<Event>>(
                                  valueListenable: _selectedEvents,
                                  builder: (context, value, _) {
                                    return ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemCount: value.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                            vertical: 3.0,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: ListTile(
                                            onTap: () =>
                                                print('${value[index]}'),
                                            title: Text(
                                              '${value[index]}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            leading: Icon(
                                              Icons.trip_origin,
                                              color: Color(0xff679fa3),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff679fa3)),
                                      child: const Text(
                                        "Ajouter une indisponibilité",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }
}
