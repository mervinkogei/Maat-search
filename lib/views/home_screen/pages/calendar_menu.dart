import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/views/home_screen/pages/add_event.dart';
import 'package:wikiapp/views/home_screen/pages/home_screen.dart';
import 'package:wikiapp/views/home_screen/pages/view_event.dart';

class CalendarMenu extends StatefulWidget {
  CalendarMenu({Key? key}) : super(key: key);

  @override
  State<CalendarMenu> createState() => _CalendarMenuState();
}

class _CalendarMenuState extends State<CalendarMenu> {
  //   final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: ['email']
  // );

  // GoogleSignInAccount ? _currentUser;
  // final FocusNode _focusNode = FocusNode();
  // String? id;
  // String? name;

  // @override
  // void initState() {
  //   _focusNode.unfocus();
  //   _googleSignIn.onCurrentUserChanged.listen((account) async{
  //    SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {     
  //     _currentUser = account;
  //     id =_currentUser!.id;
  //     name = _currentUser!.displayName;
  //     prefs.setString("tagsID", id!);
  //     prefs.setString("tagsName", name!);
  //   });
  //   if(_currentUser !=null){
  //     // Navigator.of(context).push(MaterialPageRoute(
  //     //                           builder: (context) =>  HomeScreen()));
  //   }

  //   });
  //  _googleSignIn.signInSilently();
  //   super.initState();
  //   // if(widget._checkLogout == true){
  //   //   _googleSignIn.signOut();
  //   // }else{
  //   // }
  // }

  //  Future<void> _SignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print("ERROR $error");
  //   }
  //  }
   
  // late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    // _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
         firstDay: DateTime.utc(2010, 10, 16),
         lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
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
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event.title),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                                  event: event,
                                )));
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEventPage())),
      ),
    );
  }
}