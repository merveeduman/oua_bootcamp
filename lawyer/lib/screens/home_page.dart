import 'package:flutter/material.dart';
import 'package:lawyer/components/appointment_card.dart';
import 'package:lawyer/components/lawyer_cards.dart';
import 'package:lawyer/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> advisor = [
    {
      "icon": FontAwesomeIcons.handcuffs,
      "category": "Ceza Hukuku",
    },
    {
      "icon": FontAwesomeIcons.userTie,
      "category": "İş Hukuku",
    },
    {
      "icon": FontAwesomeIcons.peopleRoof,
      "category": "Aile Hukuku",
    },
    {
      "icon": FontAwesomeIcons.handshake,
      "category": "Ticaret Hukuku",
    },
    {
      "icon": FontAwesomeIcons.book,
      "category": "Anayasa Hukuku",
    },
    {
      "icon": FontAwesomeIcons.sackDollar,
      "category": "Borçlar Hukuku",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
        //if user is empty, then return progress indicator
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Ceren',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                ],
              ),
              Config.spaceMedium,
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              SizedBox(
                height: Config.heightSize * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                  List<Widget>.generate(advisor.length, (index) {
                    return Card(
                      margin: const EdgeInsets.only(right: 20),
                      color: Config.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FaIcon(
                              advisor[index]['icon'],
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              advisor[index]['category'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Config.spaceSmall,
              const Text(
                'Bugünkü Randevuların ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              AppointmentCard(),
              Config.spaceSmall,
              const Text(
                'Avukatlar ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Column(
                children: List.generate(10, (index){
                  return LawyerCards();
                }

                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
