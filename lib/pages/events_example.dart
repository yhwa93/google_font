// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  State<TableEventsExample> createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: TableCalendar(
                  rowHeight: 80.0,
                  daysOfWeekHeight: 55.0,
                  calendarBuilders: CalendarBuilders(
                    //요일 빌더
                    dowBuilder: (context, day) {
                      switch (day.weekday) {
                        case 1:
                          return const Center(
                            child: Text(
                              'MON',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 2:
                          return const Center(
                            child: Text(
                              'TUE',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 3:
                          return const Center(
                            child: Text(
                              'WED',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 4:
                          return const Center(
                            child: Text(
                              'THU',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 5:
                          return const Center(
                            child: Text(
                              'FRI',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 6:
                          return const Center(
                            child: Text(
                              'SAT',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        case 7:
                          return const Center(
                            child: Text(
                              'SUN',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 60, 67, 0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                      }
                      return null;
                    },

                    //투데이빌더
                    todayBuilder: (context, day, focusedDay) {
                      return Container(
                        color: Colors.green,
                        margin: EdgeInsets.zero,
                        alignment: Alignment.topCenter,
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },

                    //마커 빌더 -> 스케줄 작성을 했는지 안했는지 조건문
                    markerBuilder: (context, day, events) {
                      return null;

                      // return Align(
                      //   alignment: const Alignment(0.0, 0.5),
                      //   child: Image.asset(
                      //     "assets/images/icon_01.png",
                      //     width: 48,
                      //   ),
                      // );
                    },

                    //디스에이블 빌더
                    disabledBuilder: (context, day, focusedDay) {
                      return Column(
                        children: [
                          Text(
                            day.day.toString(),
                            style: const TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          Align(
                            alignment: const Alignment(0.0, 0.5),
                            child: Image.asset(
                              "assets/images/calendar_inactive.png",
                              width: 45,
                            ),
                          ),
                        ],
                      );
                    },

                    //셀렉티드 빌더
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        alignment: Alignment.topCenter,
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },

                    //디폴트 빌더
                    defaultBuilder: (context, day, focusedDay) {
                      // return Container(
                      //   margin: EdgeInsets.zero,
                      //   alignment: Alignment.topCenter,
                      //   child: Text(
                      //     day.day.toString(),
                      //     style: const TextStyle(
                      //       color: Colors.black87,
                      //     ),
                      //   ),
                      // );

                      return Column(
                        children: [
                          Text(
                            day.day.toString(),
                            style: const TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          Align(
                            alignment: const Alignment(0.0, 0.5),
                            child: Image.asset(
                              "assets/images/calendar_inactive.png",
                              width: 45,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  //캘린더 헤더
                  headerStyle: const HeaderStyle(
                    titleCentered: false,
                    headerMargin: EdgeInsets.only(bottom: 0),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  //기본 옵션
                  headerVisible: true,
                  locale: 'ko_KR',
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: '월간',
                    CalendarFormat.week: '주간',
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  calendarStyle: const CalendarStyle(
                    // Use `CalendarStyle` to customize the UI

                    outsideDaysVisible: false,
                  ),
                  rangeSelectionMode: _rangeSelectionMode,

                  //한 주의 시작 요일
                  startingDayOfWeek: StartingDayOfWeek.sunday,

                  //비활성화 지정
                  enabledDayPredicate: (date) {
                    //https://jutole.tistory.com/96

                    final bool a = date.isAfter(DateTime.now());

                    return !a;
                  },
                  eventLoader: _getEventsForDay,
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
