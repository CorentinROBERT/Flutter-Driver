import 'dart:collection';

import 'package:driver/helpers/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';
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

  bool isMondayMorning = false;
  bool isMondayMidday = false;
  bool isMondayNight = false;

  bool isTuesdayMorning = false;
  bool isTuesdayMidday = false;
  bool isTuesdayNight = false;

  bool isWednesdayMorning = false;
  bool isWednesdayMidday = false;
  bool isWednesdayNight = false;

  bool isThursdayMorning = false;
  bool isThursdayMidday = false;
  bool isThursdayNight = false;

  bool isFridayMorning = false;
  bool isFridayMidday = false;
  bool isFridayNight = false;

  bool isSaturdayMorning = false;
  bool isSaturdayMidday = false;
  bool isSaturdayNight = false;

  bool isSundayMorning = false;
  bool isSundayMidday = false;
  bool isSundayNight = false;

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

  final data2 = {
    DateTime.now(): ["07:00 - 09:00", "09:00 - 14:00", "15:00 - 19:30"],
    DateTime.now().add(const Duration(days: 1)): [
      "09:00 - 14:00",
      "15:00 - 19:30",
      "20:00 - 23:00"
    ],
    DateTime.now().add(const Duration(days: 2)): [
      "09:00 - 14:00",
      "15:00 - 19:30",
      "20:00 - 23:00"
    ],
    DateTime.now().add(const Duration(days: 3)): [
      "09:00 - 14:00",
      "15:00 - 19:30",
      "20:00 - 23:00",
      "23:00 - 02:00"
    ],
    DateTime.now().add(const Duration(days: 4)): [
      "09:00 - 14:00",
      "15:00 - 19:30",
      "20:00 - 23:00"
    ],
    DateTime.now().add(const Duration(days: 5)): [
      "09:00 - 14:00",
      "15:00 - 19:30",
      "20:00 - 23:00"
    ],
  };

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
                  ColoredBox(
                    color: Colors.black,
                    child: ScrollableListTabScroller.defaultComponents(
                      headerContainerProps:
                          const HeaderContainerProps(height: 70),
                      tabBarProps: TabBarProps(
                        enableFeedback: false,
                        dividerColor: Colors.white.withAlpha(40),
                      ),
                      itemCount: data2.length,
                      earlyChangePositionOffset: 30,
                      tabBuilder:
                          (BuildContext context, int index, bool active) =>
                              Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: !active ? Colors.black : Colors.white,
                              shape: BoxShape.circle),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('dd/MM')
                                    .format(data2.keys.elementAt(index)),
                                style: !active
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              ),
                              Text(
                                DateFormat('EEE.')
                                    .format(data2.keys.elementAt(index)),
                                style: !active
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemBuilder: (BuildContext context, int index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 5),
                            child: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(data2.keys.elementAt(index)),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                          ...data2.values
                              .elementAt(index)
                              .asMap()
                              .map(
                                (index, value) => MapEntry(
                                  index,
                                  ListTile(
                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey),
                                      alignment: Alignment.center,
                                      child: Text(index.toString()),
                                    ),
                                    title: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                              .values
                        ],
                      ),
                    ),
                  ),
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
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            leading: const Icon(
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
                                  padding: const EdgeInsets.only(bottom: 10),
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
                  ColoredBox(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ExpansionTile(
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                title: const Text(
                                  'Lundi',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isMondayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isMondayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isMondayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isMondayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isMondayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isMondayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text(
                                  'Mardi',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isTuesdayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isTuesdayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isTuesdayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isTuesdayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isTuesdayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isTuesdayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text('Mercredi',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isWednesdayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isWednesdayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isWednesdayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isWednesdayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isWednesdayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isWednesdayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text('Jeudi',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isThursdayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isThursdayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isThursdayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isThursdayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isThursdayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isThursdayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text('Vendredi',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isFridayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isFridayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isFridayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isFridayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isFridayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isFridayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text('Samedi',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSaturdayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isSaturdayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSaturdayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isSaturdayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSaturdayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isSaturdayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: Colors.pink,
                                iconColor: Colors.pink,
                                childrenPadding:
                                    const EdgeInsets.only(left: 20),
                                title: const Text('Dimanche',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Row(
                                    children: [
                                      const Text(
                                        "Matin",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSundayMorning,
                                        onChanged: (value) {
                                          setState(() {
                                            isSundayMorning = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Midi",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSundayMidday,
                                        onChanged: (value) {
                                          setState(() {
                                            isSundayMidday = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Soir",
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                      Switch.adaptive(
                                        activeTrackColor: Colors.pink,
                                        value: isSundayNight,
                                        onChanged: (value) {
                                          setState(() {
                                            isSundayNight = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 60,
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                    "Sauvegarder les disponibilités",
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold))),
                          ),
                        )
                      ],
                    ),
                  ),
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
