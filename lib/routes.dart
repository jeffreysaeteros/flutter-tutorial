import 'plan/plan.dart';
import 'memories/memories.dart';
import 'coming/coming.dart';
import 'home/home.dart';

var appRoutes = {
  '/home': (context) => HomePage(),
  '/memories': (context) => MemoriesPage(),
  '/plan': (context) => PlanPage(),
  '/coming': (context) => ComingPage(),
};
