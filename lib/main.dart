import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:http/http.dart' as http;
import 'package:nice_button/NiceButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import 'Cardview/credit_card.dart';
import 'Cardview/extra/card_type.dart';
import 'Cardview/style/card_background.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SherSoft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: true,
          body: MyHomePage(title: 'SherAcc Key')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String path2 = "";
  static const platform = const MethodChannel('cdkey.flutter.dev/cdkey');

  List<bool> isSelected;

  getpath() async {
    bool isexist = await getaudiopathst();
    getAudiopathIm();
    if (isexist) {
      path2 = await getpathA();
    } else
      path2 = await getAudiopath();
  }

  int _counter = 0;

  var controller = TextEditingController();

  File _imageFile = null;

  Future<void> _incrementCounter() async {
    var name = controller.text;
    if (name.length > 0) {
      // var data = newcdkey
      //     ? await getFromSerialFromnet(name)
      //     : await getFromSerialFromnetold(name);
      var data = "";
      if (isSelected[0] == true) {
        data = await getFromSerialFromnetold(name);
      } else if (isSelected[2] == true) {
        var d = await _getAndroidCdkey(name);
        data = _androidcdkey;
      } else {
        data = await getFromSerialFromnet(name);
      }
      print(data);
      if (data.length > 10) {
        _sharevisible = true;
      }
      var dd = data.replaceAll('\\r', "");
      print(dd);
      dd = dd.replaceAll('\\n', "");
      print(dd);
      var setupserialkey2 = setupserialkey(dd);
      print(setupserialkey2);
      setState(() {
        if (isSelected[2] == true) {
          serialno = dd;
        } else {
          serialno = setupserialkey2;
        }

        password = controller.text;
        _sharevisible = true;
      });
    }
  }

  var serialno = null;
  var password = null;
  var _sharevisible = false;

  String setupserialkey(String serialkey) {
    var key = serialkey.replaceAll("\"", "");
    print(key);

    var result = "";
    var count = 0;
    for (int i = 1; i < key.length; i++) {
      if (i % 4 == 0) {
        count = i;
        result += key.substring(i - 4, i) + "-";
      } else if (key.length - 1 == i) {
        result += key.substring(count, key.length);
      }
    }
    return result;
  }

  var map = Map<String, String>();

  Future<String> getFromSerialFromnet(String Password) async {
    map["password"] = password;
    var url = 'http://148.72.210.101:60164/cdkey/cdkey?password=$Password';
    // var url = 'http://192.168.1.105:60164/cdkey/cdkey?password=$Password';
    var response = await http.get(url, headers: map);
    String object = 'Response status: ${response.statusCode}';
    print(object);
    String object2 = 'Response body: ${response.body}';
    String object3 = 'Response body: ${response.toString()}';

    var snackBar = SnackBar(content: Text(object + "\n" + object2 + object3));
    Scaffold.of(context).showSnackBar(snackBar);
    print(object2);

    // print(await http.read('https://example.com/foobar.txt'));
    return response.body;
  }

  Future<String> getFromSerialFromnetold(String Password) async {
    map["password"] = password;
    var url = 'http://148.72.210.101:60164/cdkey/cdkeyold?password=$Password';
    // var url = 'http://192.168.1.105:60164/cdkey/cdkey?password=$Password';
    var response = await http.get(url, headers: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // print(await http.read('https://example.com/foobar.txt'));
    return response.body;
  }

  var _controller = ScreenshotController();
  var newcdkey = true;
  var audiovalue = true;
  var newcdkey_text = "New Key";
  var audiovalue_text = "Audio On";
  Color newcdkey_color = Colors.blue;
  Color audio_color = Colors.blue;

  // Color Cardcolor = Colors.blueGrey;
  Color Cardcolor = Colors.blue;
  double pixelvalue = 5;
  int defaultv = 5;
  FlutterSliderStep _uppervalue = FlutterSliderStep();

  String getaudio() {
    new File("images/audio.png");
  }

  double font = 13.5;

  @override
  Widget build(BuildContext context) {
    // isSelected[1] = true;
    getpath();
    var children2 = <Widget>[
      Image.asset(
        "images/oldkey2.png",
        width: 28,
        height: 28,
      ),
      Image.asset(
        "images/Newkey.png",
        width: 28,
        height: 28,
      ),
      Image.asset(
        "images/andkey.png",
        width: 28,
        height: 28,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            audiovalue_text,
                            style: TextStyle(fontSize: 18, color: audio_color),
                          ),
                          Switch(
                            value: audiovalue,
                            onChanged: (bool newvalue) {
                              setState(() {
                                audiovalue = newvalue;
                                if (newvalue) {
                                  audiovalue_text = "Audio On";
                                  audio_color = Colors.blue;
                                } else {
                                  audiovalue_text = "Audio Off";
                                  audio_color = Colors.black;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Text("Card Pixel Size:${pixelvalue.round().toString()}"),
                      Container(
                          child: SingleCircularSlider(
                        50,
                        defaultv,
                        child: Center(
                            child: Text('${(pixelvalue).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 36.0, color: Colors.black54))),
                        baseColor: Colors.blue,
                        height: 150,
                        width: 150,
                        onSelectionChange: (x, y, e) {
                          setState(() {
                            pixelvalue = y.toDouble() / 3;
                          });
                        },
                      )),
                      Center(
                        child: OutlineButton(
                            onPressed: _openFullMaterialColorPicker,
                            child: const Text('Select Color')),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text(
                              //   newcdkey_text,
                              //   style: TextStyle(
                              //       fontSize: 18, color: newcdkey_color),
                              // ),

                              ToggleButtons(
                                children: children2,
                                onPressed: (int index) {
                                  // setState(() {
                                  //   isSelected = [false, false, false];
                                  // });
                                  setState(() {
                                    _sharevisible = false;
                                    for (int buttonIndex = 0;
                                        buttonIndex < isSelected.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        // setState(() {
                                        isSelected[buttonIndex] = true;
                                        // });
                                      } else {
                                        // setState(() {
                                        isSelected[buttonIndex] = false;
                                        // });
                                      }
                                    }
                                    // isSelected = [false, false, false];
                                    // isSelected[index] = true;
                                  });
                                },
                                isSelected: isSelected,
                              ),

                              // Switch(
                              //   value: newcdkey,
                              //   onChanged: (bool newvalue) {
                              //     setState(() {
                              //       newcdkey = newvalue;
                              //       if (newvalue) {
                              //         newcdkey_text = "New Key";
                              //         newcdkey_color = Colors.blue;
                              //       } else {
                              //         newcdkey_text = "Old Key";
                              //         newcdkey_color = Colors.black;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Key Size:${font.round().toString()}"),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Slider(
                          min: 10,
                          max: 20,
                          value: font,
                          divisions: 9,
                          label: font.round().toString(),
                          onChanged: (newValue) {
                            setState(() {
                              font = newValue;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: _sharevisible,
                        child: NiceButton(
                          mini: true,
                          icon: Icons.share,
                          background: Colors.blue,
                          onPressed: () {
                            print(pixelvalue.toString());
                            _controller
                                .capture(pixelRatio: pixelvalue)
                                .then((File image) async {
                              //Capture Done
                              setState(() {
                                _imageFile = image;
                              });
                              var paths = [_imageFile.path, path2];

                              if (!audiovalue) {
                                paths = [_imageFile.path];
                              }

                              if (isSelected[2] == true) {
                                Share.share("*CDKEY*" + "\n" + serialno);
                              } else {
                                Share.shareFiles(paths, text: '*Cd Key*');
                              }
                            }).catchError((onError) {
                              print(onError);
                            });

                            // final bytes = Io.File(_imageFile.path).readAsBytesSync();
                            //
                            // FlutterShareMe()
                            //     .shareToWhatsApp(base64Image: _imageFile, msg: msg);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  // onLongPress: () =>
                  // {
                  //   Clipboard.getData("text/plain").then((value) {
                  //     controller.text = value.text;
                  //   })
                  // },
                  onDoubleTap: () {
                    Clipboard.getData("text/plain").then((value) {
                      controller.text = value.text;
                    });
                  },
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Screenshot(
                        controller: _controller,
                        child: CreditCard(
                          cardNumber: serialno,
                          textfont: font,
                          cardExpiry: "",
                          cardHolderName: password,
                          cvv: "",
                          bankName: "SherSoft",
                          cardType: CardType.americanExpress,
                          showBackSide: false,
                          frontBackground: new Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            color: Cardcolor,
                          ),
                          backBackground: CardBackgrounds.white,
                          showShadow: true,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                maxLength: 20,
                obscureText: false,
                controller: controller,
                onChanged: (String str) {
                  setState(() {
                    _sharevisible = false;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = [false, true, false];
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: Cardcolor,
        onMainColorChange: (color) => setState(() => {Cardcolor = color}),
      ),
    );
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop;
                setState(() {
                  Cardcolor = Colors.blue;
                });
              },
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  Cardcolor;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> getpathA() async {
    final filename = 'zaudio.mp3';
    String dir = (await getApplicationDocumentsDirectory()).path;
    return dir + "/" + filename;
  }

  Future<String> getpathIm() async {
    final filename = 'shericon1.jpg';
    String dir = (await getApplicationDocumentsDirectory()).path;
    return dir + "/" + filename;
  }

  Future<bool> getaudiopathst() async {
    return File(await getpathA()).exists();
  }

  Future<String> getAudiopath() async {
    final String string = "images/zaudio.mp3";
//read and write
    final filename = 'zaudio.mp3';
    String dir = (await getApplicationDocumentsDirectory()).path;
    var bytes = await rootBundle.load("images/zaudio.mp3");
    writeToFile(bytes, '$dir/$filename');
//write to app path
    return "$dir/$filename";
  }

  Future<String> getAudiopathIm() async {
    final String string = "images/shericon1.jpg";
//read and write
    final filename = 'shericon1.jpg';
    String dir = (await getApplicationDocumentsDirectory()).path;
    var bytes = await rootBundle.load("images/shericon1.jpg");
    writeToFile(bytes, '$dir/$filename');
//write to app path
    return "$dir/$filename";
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  // Get battery level.
  String _androidcdkey = 'Unknown battery level.';

  Future<String> _getAndroidCdkey(String key) async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('getandcdkey', [key]);
      batteryLevel = result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get cdkey: '${e.message}'.";
    }

    setState(() {
      _androidcdkey = batteryLevel;
    });
    return batteryLevel;
  }
}
