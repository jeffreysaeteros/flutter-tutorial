import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'plan/plan.dart';
import 'routes.dart';
import 'home/home.dart';
import 'memories/memories.dart';
import 'coming/coming.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //THEME
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),

      //BUILDER - background image for screens
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(252, 238, 214, 1),
            // image: DecorationImage(
            //   image: AssetImage("assets/peach.jpg"),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: child,
        );
      },

      //HOME - tab bar
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              const Material(
                color: Colors.white,
                child: const TabBar(
                  indicatorColor: Color(0xFFFFFF),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(fontSize: 15),
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  tabs: [
                    Tab(text: "Home"),
                    Tab(text: "What's Coming"),
                    Tab(text: "Plan Something"),
                    Tab(text: "Memories"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    NavigatorWidget(routeName: '/'),
                    NavigatorWidget(routeName: '/coming'),
                    NavigatorWidget(routeName: '/plan'),
                    NavigatorWidget(routeName: '/memories'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigatorWidget extends StatelessWidget {
  final String routeName;

  // constructor - requires a route name to be passed in
  NavigatorWidget({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // settings: contains the settings for the route being generated, including name of route.
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (routeName) {
          case '/':
            builder = (_) => HomePage();
            break;
          case '/memories':
            builder = (_) => MemoriesPage();
            break;
          case '/plan':
            builder = (_) => PlanPage();
            break;
          case '/coming':
            builder = (_) => ComingPage();
            break;
          default:
            throw Exception('Invalid route: $settings.name');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
