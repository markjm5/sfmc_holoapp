import 'package:flutter/material.dart';
import 'package:sfmc_holoapp/blocks/auth_block.dart';
import 'package:sfmc_holoapp/models/user.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function androidLogEvent;
  final Function registerTap;

  SignIn(this.androidLogEvent, this.registerTap);

  @override
  _SignInState createState() => _SignInState(androidLogEvent, registerTap);
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final UserCredential userCredential = UserCredential();
  final Function _androidLogEvent;
  final Function _registerTap;  

  @override
  _SignInState(this._androidLogEvent, this._registerTap);


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(top: 3.0, left: 8.0, right: 8.0, bottom: 3.0),child: new Image.network('https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/modules/intelligent-marketing-and-customer-service-for-banks/connect-with-customers-in-a-whole-new-way/images/7543698e46ecb7b4d3687cefd9146977_cj-670-th-7-z-00440-s-9-m-0-vdl-74-i-5.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email or Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _registerTap('setUserId',value, _androidLogEvent);

                        setState(() {
                          userCredential.usernameOrEmail = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Username Or Email',
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    onSaved: (value) {

                      setState(() {
                        userCredential.password = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(
                        builder:
                            (BuildContext context, AuthBlock auth, Widget child) {
                          return RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: auth.loading && auth.loadingType == 'login' ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ) : Text('Sign In'),
                            onPressed: () {
                              // Validate form
                              if (_formKey.currentState.validate() && !auth.loading) {
                                // Update values
                                _formKey.currentState.save();
                                // Hit Api
                                auth.login(userCredential);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
