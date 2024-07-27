import 'package:flutter/material.dart';
import 'package:lawyer/utils/config.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.social}) : super(key: key);

  final String social;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
      onPressed: (){},
      child: SizedBox(
        width: Config.screenWidth! * 0.33,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/$social.png',
              width: 35,
              height: 35,
            ),
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}