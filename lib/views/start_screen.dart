import 'package:flutter/material.dart';
import 'package:news_app_api/models/country.dart';
import 'package:news_app_api/views/homepage.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "The ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    "News 📰",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: size.height * 0.6,
            child: Column(
              children: countriesCode.asMap().entries.map((e) {
                return CountryButton(
                  mapKey: e.value,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CountryButton extends StatelessWidget {
  final mapKey;

  const CountryButton({this.mapKey});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton.icon(
        padding: EdgeInsets.all(8),
        onPressed: () {
          var country = Provider.of<Country>(context, listen: false);
          country.changeCode(mapKey);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('icons/flags/png/$mapKey.png',
              package: 'country_icons'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(
          '${countries[mapKey]}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
