import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/http_exception.dart';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-FW6cbCQNK-VZYwLGmwVia1WoJ7KgFqc4duaHvzJu3AIEUS4FqUMbbawySjguFCJmhIc&usqp=CAU'),fit: BoxFit.cover,height: deviceSize.height,width: deviceSize.width,),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController? _controller;

  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(end: Offset(0, 0), begin: Offset(0, -1.5))
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn));
    // _heightAnimation.addListener(
    //   () => setState(() {}),
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('An error accured!'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'))
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      //Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = " This email address is already in use";
      } else if (e.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This not a valid email";
      } else if (e.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too week";
      } else if (e.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "could not find user with this email";
      } else if (e.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "invalid  password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller?.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller?.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
          height: _authMode == AuthMode.Signup ? 320 : 260,
          //height: _heightAnimation.value.height,
          constraints:
              BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260
                  //_heightAnimation.value.height,
                  ),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Invalid email';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  //    if (_authMode == AuthMode.Signup)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                        maxHeight: _authMode == AuthMode.Signup ? 120 : 0),
                    curve: Curves.easeIn,
                    child: FadeTransition(
                      opacity: _opacityAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password'),
                          enabled: _authMode == AuthMode.Signup,
                          obscureText: true,
                          controller: _passwordController,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value! != _passwordController.text) {
                                    return 'Password do not match!';
                                  }
                                }
                              : null,
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    ),
                  TextButton(
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD',style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _switchAuthMode,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
