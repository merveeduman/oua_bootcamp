import 'package:flutter/material.dart';
import 'package:lawyer/utils/config.dart';

class AppointmentCard extends StatefulWidget {
  AppointmentCard({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const <Widget>[
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/profile1.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Bora Balkan',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'İş Hukuku',
                          style: const TextStyle(color: Colors.black),
                        )
                      ],),
                ],
              ),
              Config.spaceSmall,
              const ScheduleCard(),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.calendar_today,
            color: Colors.black,
            size: 12,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Pazartesi, 22/07/2024',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '14:00',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
