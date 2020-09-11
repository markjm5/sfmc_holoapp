import 'package:flutter/material.dart';
import 'package:sfmc_holoapp/models/user.dart';
import 'package:sfmc_holoapp/blocks/auth_block.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function androidLogEvent;
  final Function registerTap;

  SignUp(this.androidLogEvent, this.registerTap);
  
  @override
  _SignUpState createState() => _SignUpState(androidLogEvent, registerTap);
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final Function _androidLogEvent;
  final Function _registerTap;

  final User user = User();
  String confirmPassword;

  @override
  _SignUpState(this._androidLogEvent, this._registerTap);

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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _registerTap('setUserId',value, _androidLogEvent);

                        setState(() {
                          user.username = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Username',
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email Address';
                        }
                        return null;
                      },
                      onSaved: (value) {

                        setState(() {
                          user.email = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        onSaved: (value) {

                          setState(() {
                            user.password = value;
                          });
                        },
                        onChanged: (text) {
                          user.password = text;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                        obscureText: true),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Confirm Password';
                      } else if (user.password != confirmPassword) {
                        return 'Password fields dont match';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      confirmPassword = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Same Password',
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(builder:
                          (BuildContext context, AuthBlock auth, Widget child) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: auth.loading && auth.loadingType == 'register' ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ) : Text('Sign Up'),
                          onPressed: () {
                            if (_formKey.currentState.validate() && !auth.loading) {
                              _formKey.currentState.save();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.                              
                              auth.register(user);

                              //Call Interation Studio here to set user credentials
                              // ...
                            }
                          },
                        );
                      }),
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
