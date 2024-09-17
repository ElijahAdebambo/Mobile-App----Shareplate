import 'package:flutter/material.dart';
import 'donatepage.dart';
import 'favouritepage.dart';
import 'foodbankpage.dart';
import 'settingspage.dart';
import 'loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'introduction_screen.dart';

//implemented using labs on naviation and widgets



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MyApp());
}
Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharePlate',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: OnBoardingPage( ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CardExample(),
    DonatePage(),
    FavouritePage(),
    FoodbankPage(),
    SettingsPage(),
  ];

  final List<String> _titles = [
    'Home',
    'Donate',
    'Favourites',
    'Foodbank',
    'Settings',
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.card_giftcard_sharp,
    Icons.bookmark,
    Icons.food_bank,
    Icons.settings,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(_icons[_selectedIndex]),
            SizedBox(width: 8),
            Text(_titles[_selectedIndex]),
          ],
        ),
      ),
      body: Center(
        // Display the selected page
        child: _pages.elementAt(_selectedIndex),

      ),
      drawer: Drawer(
        // Drawer with navigation options
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset('assets/logo.png'), // Logo image
            ),
            Text('SharePlate', style: TextStyle(color: Colors.white)), // Optional text
          ],
        ),
      ),


            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Donate'),
              leading: Icon(Icons.card_giftcard_sharp),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.bookmark),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Foodbank'),
              leading: Icon(Icons.food_bank),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Donate'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Foodbank'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[800],
        backgroundColor: Colors.lightBlue,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: Colors.lightBlue.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/world.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 12),
                Text(
                  'Welcome to SharePlate!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Title font size
                    color: Colors.black, // Title color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'SharePlate helps you connect with your community to share meals, '
                      'reduce waste, and support those in need.',
                  style: TextStyle(
                    fontSize: 16, // Subtitle font size
                    color: Colors.black54, // Subtitle color
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(

              children: [

                ListTile(
                  leading: Icon(Icons.church),
                  title: Text('The Salvation Army'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Open Now.'),
                      Text('020 7367 4800'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),

                ListTile(
                  leading: Icon(Icons.food_bank_rounded),
                  title: Text('Himmah Food bank'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Opens Soon - 10am - 4pm'),
                      Text('0115 837 6116'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),  ListTile(
                  leading: Icon(Icons.church),
                  title: Text('Rushcliffe Food Bank/Church'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Closed Now - Opens Saturday, 9–11:30am.'),
                      Text('07581 422396'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),  ListTile(
                  leading: Icon(Icons.cabin),
                  title: Text('Remar Nottingham Community Kitchen Foodbank'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Opens 9–11:30am.'),
                      Text('07917 585067'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),  ListTile(
                  leading: Icon(Icons.food_bank_rounded),
                  title: Text('Arena Community Foodbank'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Opens Soon - 10am.'),
                      Text(' 0115 944 1462'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),  ListTile(
                  leading: Icon(Icons.food_bank_rounded),
                  title: Text('Arnold Foodbank - part of The Trussell Trust network'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Closed Today.'),
                      Text('07854 690694'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text('CONTACT US'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('DIRECTIONS'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
