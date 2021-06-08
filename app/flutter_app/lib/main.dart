import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController userInput = new TextEditingController();
  String userString = "";
  bool startedTyping = false;
  bool deletedEverything = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String pickMessage() {
      if (!startedTyping) {
        return "Type something in >:(";
      } else {
        if (deletedEverything) {
          return "can't even decide, god.";
        } else {
          return "At least you're trying... Press the arrow.";
        }
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: size.height * 0.05,
              ),
              Expanded(
                  child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (text) {
                      if (text.trim().isNotEmpty) {
                        startedTyping = true;
                        deletedEverything = false;
                      } else {
                        if (startedTyping) {
                          deletedEverything = true;
                        }
                      }
                      print('First text field: $text');
                    },
                    enableSuggestions: false,
                    obscureText: false,
                    controller: userInput,
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      border: InputBorder.none,
                      fillColor: Colors.black,
                      hintText: "Tell me what's on your mind?",
                      suffixIcon: IconButton(
                        onPressed: () {
                          userString = userInput.text.toString().trim();
                          print(userString);
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(Icons.arrow_forward_rounded),
                      ),
                    ),
                  ),
                ),
              )),
              Container(
                height: size.height * 0.05,
              ),
              Expanded(
                  child: Container(
                child: userString.isEmpty
                    ? Center(child: Text(pickMessage()))
                    : tweet(),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
              )),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class tweet extends StatefulWidget {
  @override
  _tweetState createState() => _tweetState();
}

class _tweetState extends State<tweet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 7),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "# Matching Tweet",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 9,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/85.jpg'),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Joseph Stalin",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "@JosephStalin",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
