import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class PlayerStatListItem extends StatelessWidget {
  const PlayerStatListItem({
    super.key,
    required this.avatar,
    required this.title,
    required this.subtitle,
    required this.stat,
  });

  final String avatar;
  final String title;
  final String subtitle;
  final String stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Container(
            height: 72,
            width: 72,
            //color: Colors.deepPurple,
            child: ImageNetwork(
              image: avatar,
              height: 72,
              width: 72,
              duration: 1000,
              curve: Curves.easeIn,
              fitAndroidIos: BoxFit.cover,
              fitWeb: BoxFitWeb.cover,
              borderRadius: BorderRadius.circular(64),
            ),
          ),
          Expanded(
            child: Container(
              height: 72,
              //color: Colors.amberAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Container(
            height: 72,
            width: 96,
            //color: Colors.blueAccent,
            child: Center(
              child: Text(
                stat,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 20.0),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ],
      ),
    );
  }
}
