import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lawyer/components/button.dart';
import 'package:lawyer/utils/config.dart';
import '../components//custom_appbar.dart';

class LawyerDetails extends StatefulWidget {
  const LawyerDetails({Key? key}) : super(key: key);

  @override
  State<LawyerDetails> createState() => _LawyerDetailsState();
}

class _LawyerDetailsState extends State<LawyerDetails> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Avukat Hakkında',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AboutLawyer(),
            DetailBody(),
            const Spacer(),
            Padding(padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Randevu Alma',
                onPressed: (){

                  Navigator.of(context).pushNamed('booking_page');
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutLawyer extends StatelessWidget {
  const AboutLawyer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage('assets/profile2.png'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          const Text(
            'Emre Gür',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Avukat hakkında açıklama yazısı bu kısımda yer alır',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'çalıştığı büro',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          const LawyerInfo(),
          Config.spaceMedium,
          const Text(
            'About lawyer',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          const Text(
            'avukat hakkında genel bilgiler bu kısımda yer alır',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class LawyerInfo extends StatelessWidget {
  const LawyerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        InfoCard(label: 'Danışan', value: '109'),
        SizedBox(width: 15,),
        InfoCard(label: 'Deneyimler', value: '10 yıl'),
        SizedBox(width: 15,),
        InfoCard(label: 'Değerlendirme', value: '4.5'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

