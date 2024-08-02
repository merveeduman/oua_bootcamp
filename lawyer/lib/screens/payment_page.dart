import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color(0xFF4b5d4a);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVUKATIM',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _isFrontVisible = true;

  void _toggleCardSide() {
    setState(() {
      _isFrontVisible = !_isFrontVisible;
    });
  }

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      _showPaymentSuccessDialog();
      _clearControllers();
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: MyApp.primaryColor,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Ödeme Başarılı',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Ödemeniz başarıyla gerçekleştirildi.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearControllers() {
    _cardNumberController.clear();
    _expiryDateController.clear();
    _cvvController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödeme Sayfası'),
        backgroundColor: MyApp.primaryColor, 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _toggleCardSide,
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 500),
                    crossFadeState: _isFrontVisible
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: _buildFrontCard(),
                    secondChild: _buildBackCard(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(labelText: 'Kart Numarası'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kart numarası giriniz';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(labelText: 'Son Kullanma Tarihi (MM/YY)'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Son kullanma tarihi giriniz';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: InputDecoration(labelText: 'CVV'),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'CVV giriniz';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitPayment,
                  style: ElevatedButton.styleFrom(
                    primary: MyApp.primaryColor, 
                  ),
                  child: Text('Ödeme Yap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    String cardNumber = _cardNumberController.text;
    if (cardNumber.isEmpty) {
      cardNumber = '#### #### #### ####';
    } else {
      cardNumber = cardNumber.replaceAllMapped(
          RegExp(r'^(\d{4})(\d{4})(\d{4})(\d{4})$'),
              (Match m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]}');
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[600]!, Colors.blueGrey[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: Text(
              '• BANKA KARTI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), 
              Text(
                'Kart Numarası',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                cardNumber,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MM/YY',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    _expiryDateController.text.isEmpty ? 'MM/YY' : _expiryDateController.text,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[600]!, Colors.blueGrey[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CVV',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            _cvvController.text.isEmpty ? '###' : _cvvController.text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Spacer(),
          Text(
            'Güvenlik Kodu',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
