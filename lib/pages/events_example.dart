// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  final CalendarFormat _calendarFormat = CalendarFormat.month;
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
            Padding(
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
                                color: Color.fromARGB(153, 33, 149, 243),
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      case 7:
                        return const Center(
                          child: Text(
                            'SUN',
                            style: TextStyle(
                                color: Color.fromARGB(146, 244, 67, 54),
                                fontWeight: FontWeight.w600),
                          ),
                        );
                    }
                    return null;
                  },
            
                  //투데이빌더
                  todayBuilder: (context, day, focusedDay) {
                    return Column(
                      children: [
                        Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/calendar_active_date.png",
                            // fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  },
            
                  //마커 빌더 -> 스케줄 작성을 했는지 안했는지 조건문
                  markerBuilder: (context, day, events) {
                    if(events.isNotEmpty){
                      List iconEvents = events;
                      
                  
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: iconEvents.length,
                        itemBuilder:(context, index) {
                          return null;
                        

                        //   if(index == 0){
                        //     return const Align(
                        //     alignment: Alignment.bottomCenter,
                            
                        //     child: Icon(
                        //       size: 13,
                        //       color: Color.fromARGB(255, 20, 34, 20),
                        //       Icons.star,
                        //     ),
                        //   );
                        //   } else if(index == 1){
                        //     return const Align(
                        //     alignment: Alignment.bottomCenter,
                            
                        //     child: Icon(
                        //       size: 13,
                        //       color: Color.fromARGB(255, 20, 34, 20),
                        //       Icons.access_alarm,
                        //     ),
                        //   );
                        //   } else if(index == 2){
                        //     return const Align(
                        //     alignment: Alignment.bottomCenter,
                            
                        //     child: Icon(
                        //       size: 13,
                        //       color: Color.fromARGB(255, 20, 34, 20),
                        //       Icons.money_off,
                        //     ),
                        //   );
                        //   } else {
                        //     return const Align(
                        //     alignment: Alignment.bottomCenter,
                            
                        //     child: Icon(
                        //       size: 13,
                        //       color: Color.fromARGB(255, 20, 34, 20),
                        //       Icons.backpack,
                        //     ),
                        //   );
                        // }
                          
                        },
                      );
                    }
                    return null;
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
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/calendar_inactive_bg.png",
                            width: 45,
                          ),
                        ),
                      ],
                    );
                  },
            
                  //셀렉티드 빌더
                  selectedBuilder: (context, day, focusedDay) {
                    return Column(
                      children: [
                        Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/calendar_active_date.png",
                            // fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  },
            
                  //디폴트 빌더
                  defaultBuilder: (context, day, focusedDay) {
                    return Column(
                      children: [
                        Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/calendar_active_bg.png",
                            width: 45,
                          ),
                        ),
                      ],
                    );
                  },
                ),
            
                //캘린더 헤더
                headerStyle:  HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                   titleTextFormatter: (date, locale) =>
              DateFormat.yMMMMd(locale).format(date),
                  headerMargin: const EdgeInsets.only(bottom: 0),
                  titleTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 28,
                  ),
                  rightChevronIcon: const Icon(
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
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: '월간',
                  CalendarFormat.week: '주간',
                },
                // onFormatChanged: (format) {
                //   if (_calendarFormat != format) {
                //     setState(() {
                //       _calendarFormat = format;
                //     });
                //   }
                // },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: true,
                  outsideTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  outsideDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image:AssetImage('assets/images/calendar_inactive_bg.png'),
                    ),
                  ),
                ),
                rangeSelectionMode: _rangeSelectionMode,
            
                //한 주의 시작 요일
                startingDayOfWeek: StartingDayOfWeek.sunday,
            
                //비활성화 지정
                enabledDayPredicate: (date) {
                  int currentMonth = DateTime.now().month;
                  int inputMonth = date.month;

                  // DateTime currentDate = DateTime.now();
                  // DateTime inputDate = date;
                  // bool isNextDate = inputDate.isAfter(currentDate);
                  // bool isPrevDate = inputDate.isBefore(currentDate);
                  

                  if(currentMonth >= inputMonth){
                    return true;
                  }
        
                  return false;
                },
                eventLoader: _getEventsForDay,
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
          //   Expanded(
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () => print('${value[index]}'),
          //               title: Text('${value[index]}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          ],
        ),
      ),
    );
  }
}
