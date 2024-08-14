import 'package:flutter/material.dart';
import 'common_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentCallsPage extends StatelessWidget {
  const RecentCallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.04;
    final double fontSize = screenSize.width * 0.045;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '최근 기록',
            style: TextStyle(color: Colors.black, fontSize: fontSize * 1.5),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CallRecord(
                    name: '김AA',
                    phoneNumber: '010-1111-1111',
                    dateTime: '07-12 21:39',
                    isMissed: false,
                  ),
                  CallRecord(
                    name: '김BB',
                    phoneNumber: '010-1111-2222',
                    dateTime: '07-12 21:35',
                    isMissed: false,
                  ),
                  CallRecord(
                    name: '김CC',
                    phoneNumber: '010-1111-3333',
                    dateTime: '07-12 21:30',
                    isMissed: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3),
    );
  }
}

class CallRecord extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String dateTime;
  final bool isMissed;

  const CallRecord({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.dateTime,
    required this.isMissed,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.045;

    return Card(
      color: isMissed ? Colors.red[50] : Colors.grey[100], // 색상 설정
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: isMissed ? Colors.red : Colors.black,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.005),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: fontSize * 0.85,
                    color: isMissed ? Colors.red : Colors.black,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.005),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: fontSize * 0.85,
                    color: isMissed ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.phone,
                color: isMissed ? Colors.red : Colors.black,
                size: screenSize.width * 0.07,
              ),
              onPressed: () => _makePhoneCall(phoneNumber),
            ),
          ],
        ),
      ),
    );
  }
}
