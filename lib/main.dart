import 'package:flutter/material.dart';

void main() => runApp(SimpleInterestCalc());

class SimpleInterestCalc extends StatefulWidget {
  _SimpleInterestCalcState createState() => _SimpleInterestCalcState();
}

class _SimpleInterestCalcState extends State<SimpleInterestCalc> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollor', 'Pounds'];
  var _currentItemSelected;
  var displayResult = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  //to control input field
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calc',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Form(
          key: _formKey, //to identify form
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 20.0, 0, 0),
                  child: Image.asset('images/money.png'),
                  height: 100.0,
                  width: 120.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    controller: principalController, //to control input field
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter principal amount.';
                      } else if (value.length > 0) return null;
                    },
                    autovalidate: true,

                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Principal e.g. 12000',
                        errorStyle:
                            TextStyle(color: Colors.pink, fontSize: 15.0),
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    controller: roiController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter rate of interest';
                      } else if (value.length > 0) return null;
                    },
                    autovalidate: true,
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'In Percent',
                        errorStyle:
                            TextStyle(color: Colors.pink, fontSize: 15.0),
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          controller: timeController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter time in year';
                            } else if (value.length > 0) return null;
                          },
                          autovalidate: true,
                          decoration: InputDecoration(
                              labelText: 'Time',
                              hintText: 'In Year',
                              errorStyle:
                                  TextStyle(color: Colors.pink, fontSize: 15.0),
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double time = double.parse(timeController.text);

    double totalAmountPayable = principal + (principal * roi * time) / 100;
    totalAmountPayable.toStringAsFixed(2);

    String result =
        'After $time years , your investment will be worth $totalAmountPayable $_currentItemSelected';

    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    timeController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
