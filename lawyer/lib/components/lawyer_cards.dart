import 'package:flutter/material.dart';
import 'package:lawyer/utils/config.dart';

class LawyerCards extends StatelessWidget {
  const LawyerCards({Key? key, required this.route}) : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(children: [
            SizedBox(
              width: Config.widthSize * 0.33,
              child: Image.asset(
                'assets/profile2.png',
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Emre Gür',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ceza Hukuku',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Text('4.5'),
                        Spacer(
                          flex: 1,
                        ),
                        Text('Görüntülenme'),
                        Spacer(
                          flex: 1,
                        ),
                        Text('(20)'),
                        Spacer(
                          flex: 7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        onTap: (){
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
