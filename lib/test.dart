import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';

void main() {
  runApp(MaterialApp(
    home: CountrySelectionPage(),
  ));
}

class CountrySelectionPage extends StatefulWidget {
  @override
  _CountrySelectionPageState createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  Country _selectedCountry = Country.US; // Default selected country

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountryPicker(
              showDialingCode: true,
              showName: true,
              onChanged: (Country country) {
                setState(() {
                  _selectedCountry = country;
                });
              },
              selectedCountry: _selectedCountry,
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected Country: ${_selectedCountry.displayName}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
