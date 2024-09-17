import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plate1/main.dart';
import 'register.dart';

// implemented using lab sheet on authentication

final FirebaseAuth _auth = FirebaseAuth.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return TextButton(
              child: const Text('Sign out'),
              style: TextButton.styleFrom(
                  primary: Colors.white
              ),
              onPressed: () async {
                User user;
                if (_auth.currentUser != null) {
                  user = _auth.currentUser as User;
                  await _auth.signOut();
                  final String uid = user.uid;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(uid + ' has successfully signed out.'),
                  ));
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
              },
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _EmailPasswordForm(),
            _RegisterEmailSection(),


            //TODO: UI widgets will go here.
          ],
        );
      }),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userEmail = "";
  String _loginMessage = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text(' Sign in with Email & Password'),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                // Use Navigator to push RegisterPage onto the stack
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndPassword();
                }
              },
              child: const Text('Submit'),
            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(_loginMessage,
                style: TextStyle(color: Colors.red)),
          ),

        ],
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
// Navigate to the Home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        setState(() {
          _loginMessage = "Error logging in. Please check your email and password.";
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loginMessage = "Error logging in. Email or password is incorrect";
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword1() async {
    final user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _userEmail = user!.email as String;
        _loginMessage = "$_userEmail logged in successfully";
      });
    } else {
      setState(() {
        _loginMessage = "Error logging in";
      });
    }
  }
}
//
class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() =>
      _RegisterEmailSectionState();
}
class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userEmail = "";
  String _regMessage = "";

  @override
  Widget build(BuildContext){
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [




            Container(
              alignment: Alignment.center,
              child: Text(_regMessage),
            ),
          ],
        )
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}