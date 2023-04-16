import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/UI/add_stats_screen.dart';
import 'package:flutter_application_1/UI/player_stat_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MouseDraggableScrollBehavior extends CupertinoScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

final _futureShots = Supabase.instance.client
    .from('players')
    .select<List<Map<String, dynamic>>>()
    .order('shots', ascending: false);

final _futureRebound = Supabase.instance.client
    .from('players')
    .select<List<Map<String, dynamic>>>()
    .order('rebounder_mins', ascending: false);

final _futureWrist = Supabase.instance.client
    .from('players')
    .select<List<Map<String, dynamic>>>()
    .order('wrist_roller_reps', ascending: false);

void _refresh() {
  //_MyHomePageState().setState(() {});
  //_futureShots;
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController();

  var appBarTitleText = const Text("Shooting Leaderboard");
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitleText,
        backgroundColor: Colors.deepOrange,
      ),
      body: PageView(
        controller: controller,
        allowImplicitScrolling: true,
        scrollBehavior: MouseDraggableScrollBehavior(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (num) {
          setState(() {
            _selectedIndex = num;
            updateTitle(num);
          });
        },
        children: const [
          PlayerListWidget(stat: 'shots'),
          PlayerListWidget(stat: 'rebounder_mins'),
          PlayerListWidget(stat: 'wrist_roller_reps'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.lightBlue,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
        //iconSize: 32,
        selectedFontSize: 20,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //icon: Icon(Icons.sports_hockey),
            icon: Icon(Icons.scatter_plot),
            label: 'Shots',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_ping_sharp),
            label: 'Rebounds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_sharp),
            label: 'Wrist Rollers',
          ),
        ],
      ),
    );
  }

  void updateTitle(int num) {
    switch (num) {
      case 0:
        {
          setState(() {
            appBarTitleText = const Text("Shooting Leaderboard");
          });
        }
        break;
      case 1:
        {
          setState(() {
            appBarTitleText = const Text("Rebounder Leaderboard");
          });
        }
        break;
      case 2:
        {
          setState(() {
            appBarTitleText = const Text("Wrist Roller Leaderboard");
          });
        }
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      controller.jumpToPage(index);
    });
  }
}

class PlayerListWidget extends StatelessWidget {
  final String stat;

  const PlayerListWidget({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getStats(stat),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final players = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 18),
          itemCount: players.length,
          itemBuilder: ((context, index) {
            final player = players[index];
            return InkWell(
              onTap: () async {
                var refresh = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return AddStatPage(player: player);
                }));
                if (refresh) {
                  _refresh();
                }
              },
              child: PlayerStatListItem(
                avatar: player['avatar'],
                title: player['first'] + ' ' + player['last'],
                subtitle: '#${player['number'].toString()}',
                stat: player[stat].toString(),
              ),
            );
          }),
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
        );
      },
    );
  }

  getStats(String stat) {
    switch (stat) {
      case 'shots':
        return _futureShots;
      case 'rebounder_mins':
        return _futureRebound;
      case 'wrist_roller_reps':
        return _futureWrist;
      default:
        return _futureShots;
    }
  }
}
