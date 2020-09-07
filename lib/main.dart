import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sfmc_holoapp/auth/auth.dart';
import 'package:sfmc_holoapp/blocks/auth_block.dart';
import 'package:sfmc_holoapp/cart.dart';
import 'package:sfmc_holoapp/categorise.dart';
import 'package:sfmc_holoapp/home/home.dart';
import 'package:sfmc_holoapp/localizations.dart';
import 'package:sfmc_holoapp/product_detail.dart';
import 'package:sfmc_holoapp/settings.dart';
import 'package:sfmc_holoapp/shop/shop.dart';
import 'package:sfmc_holoapp/wishlist.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

 static Locale locale = Locale('en');
 static const platform = const MethodChannel('demo.sfmc_holoapp/info'); 
 String _message;

  @override
  void initState(){

    _androidInitialize().then((String message){
      setState(() {
        _message = message;        
      });   
   });

   super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock())],
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale('en'), Locale('ar')],
        locale: locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.lightBlue[700],
            accentColor: Colors.lightBlue[900],
            fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato'),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => Home(_androidLogEvent, _registerTap),
          '/auth': (BuildContext context) => Auth(_androidLogEvent, _registerTap),
          '/shop': (BuildContext context) => Shop(),
          '/categorise': (BuildContext context) => Categorise(),
          '/wishlist': (BuildContext context) => WishList(),
          '/cart': (BuildContext context) => CartList(),
          '/settings': (BuildContext context) => Settings(),
          '/products': (BuildContext context) => Products()
        },
      ),
    );
  }

  void _registerTap(String tapEvent, String tapDescription, Function androidLogEvent) {
    androidLogEvent(tapEvent, tapDescription).then((String message){
      setState(() {
        _message = message;        
      });   
   });
  }

  Future<String> _androidInitialize() async {

    var sendMap = <String, dynamic> {
      'account': 'interactionstudio',
      'ds': 'mmukherjee_sandbox',
    };

    String value;
    try {
      value = await platform.invokeMethod('androidInitialize', sendMap);
      print("initialize: " + value.toString());
    } catch (e){
      print(e);
    }

    return value;
  }

  Future<String> _androidLogEvent(String tapEvent, String tapDescription) async {
    var sendMap = <String, dynamic> {
      'event': tapEvent,
      'description': tapDescription,
    };

    String value;
    try {
      value = await platform.invokeMethod('androidLogEvent', sendMap);
      print("log event: " + value.toString());

    } catch (e){
      print(e);
    }

    return value;
  }    

}