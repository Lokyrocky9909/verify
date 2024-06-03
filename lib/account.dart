import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verify/icon_gender.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final formkey = GlobalKey<FormState>();
  final Scaffoldkey = GlobalKey<ScaffoldState>();
  File? galleryFile;
  final picker = ImagePicker();
  String _firstname = '';
  String _middlename = '';
  String _familyname = '';
  String selectedGender = '';
  String? _password = '';
  String? _confirmPassword = '';
  int? _enteredValue;
  bool _showText = false;
  String _state = '';
  String _city = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != _password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  int showMsg() {
    ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
        const SnackBar(content: Text("Hi don't hit me")));
    return 2;
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  String? _selectedCountry; // Store the selected country

  List<String> _countryList = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'India',
    'Japan',
    'China',
    'South Korea',
  ];

  void _register() {
    if (formkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registered successfully'),
          duration: Duration(seconds: 3), // Duration to display the SnackBar
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute when the "Close" action is pressed
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      formkey.currentState!.save();
      print("first name:$_firstname");
      print("middle name:$_middlename");
      print("family name:$_familyname");
      print("genger:$selectedGender");
      print("DOB:$_selectedDate");
      print("password:$_password");
      print("confirm password:$_confirmPassword");
      print("country:$_selectedCountry");
      print("postal code:$_enteredValue");
      print("state:$_state");
      print("city:$_city");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please fill all the value!'),
          duration: Duration(seconds: 3), // Duration to display the SnackBar
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute when the "Close" action is pressed
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  String? _validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a country';
    }
    return null;
  }

  String? _validateInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    } else if (value.length > 6) {
      return 'Incorrect postal code';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid integer';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _selectedDate.toLocal().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: Scaffoldkey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red.shade50,
            Colors.red.shade50,
          ])),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _showPicker(context: context);
                  },
                  child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: galleryFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                galleryFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 420,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showMsg();
                            },
                            child: Text("Demographics",
                                textAlign:
                                    TextAlign.right, // Adjust text alignment
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade600,
                                )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter first name";
                                    }
                                  },
                                  onSaved: (value) {
                                    _firstname = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'First name',
                                  ),
                                  // Other properties...
                                ),
                              ),
                              SizedBox(
                                  width:
                                      16), // Add some spacing between the fields
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter middle name";
                                    }
                                  },
                                  onSaved: (value) {
                                    _middlename = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'middle name',
                                  ),
                                  // Other properties...
                                ),
                              ),
                            ],
                          ),
                          Container(
                              child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter user name";
                              } else if (value.length > 8) {
                                return "type maximum 8 characters";
                              }
                            },
                            onSaved: (value) {
                              _familyname = value!;
                            },
                            decoration: InputDecoration(
                              labelText: 'Family name',
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                GenderIcon(
                                  selected: selectedGender == 'Female',
                                  imagePath: 'assets/female.png',
                                  gender: 'Female',
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = 'Female';
                                    });
                                  },
                                ),
                                SizedBox(height: 32),
                                GenderIcon(
                                  selected: selectedGender == 'Male',
                                  imagePath: 'assets/male.png',
                                  gender: 'Male',
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = 'Male';
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 170,
                                ),
                                _showText
                                    ? Visibility(
                                        visible: _showText,
                                        child: Text(
                                          'please select gender',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : SizedBox(),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                  labelText: 'DOB  yyyy/MM/dd',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 450,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Information",
                            textAlign: TextAlign.right, // Adjust text alignment
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            )),
                        TextFormField(
                            validator: _passwordValidator,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "password",
                            )),
                        TextFormField(
                            validator: _confirmPasswordValidator,
                            onChanged: (value) {
                              setState(() {
                                _confirmPassword = value;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "confirm password",
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: DropdownButtonFormField<String>(
                                    validator: _validateCountry,
                                    value: _selectedCountry,
                                    hint: Text("Select country"),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedCountry = newValue;
                                      });
                                    },
                                    items: _countryList
                                        .map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    isExpanded: true,
                                  )),
                            ),
                            SizedBox(
                                width:
                                    16), // Add some spacing between the fields
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Postal Code',
                                ),
                                validator: _validateInteger,
                                onSaved: (value) {
                                  if (value != null) {
                                    _enteredValue = int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your state";
                            }
                          },
                          onSaved: (value) {
                            _state = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'State',
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your city";
                            }
                          },
                          onSaved: (value) {
                            _city = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'city',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      _showText = selectedGender == "" ? true : false;
                      _register();
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
