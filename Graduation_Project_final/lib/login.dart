import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_final/register.dart';
import 'package:graduation_project_final/upload.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // borderSide: const BorderSide(width: 4.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Image(
                    image: AssetImage('assets/images/Picture3.png'),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    iconColor: Colors.purple,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'enter your email',
                    hintStyle: const TextStyle(fontSize: 15.0),
                    labelText: 'Email',
                    labelStyle: const TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(width: 4.0),
                    ),
                  ),
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _isObscure3,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    iconColor: Colors.purple,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure3
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure3 = !_isObscure3;
                        });
                      },
                    ),
                    hintText: 'enter your password',
                    hintStyle: const TextStyle(fontSize: 15.0),
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(width: 4.0),
                    ),
                  ),
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.fromLTRB(25, 15, 25, 15),
                  ),
                  elevation: const MaterialStatePropertyAll(10.0),
                ),
                onPressed: () {
                  setState(() {
                    visible = true;
                  });
                  signIn(emailController.text, passwordController.text);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Upload(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          const Text("No user found for that email.");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          const Text("Wrong password provided for that user.");
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
