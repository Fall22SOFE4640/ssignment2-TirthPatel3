import 'package:assignment2/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share/share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  "Oeschinen Lake Campground",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              )
            ],
          )),
          const FavoriteWidget(),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    //Build the button section
    Widget buttonSelection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color,Icons.call,'CALL',callAction),
          _buildButtonColumn(color,Icons.near_me,'ROUTE',routeAction),
          _buildButtonColumn(color,Icons.share,'SHARE',shareAction),
        ],
      ),
    );
    // Build the Text Area section

    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Oeschinen Lake Campground',
          ),
        ),
        body: ListView(
          children:[
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSelection,
            textSection,
          ],
        ),
      ),
    );
  }
}
//Building the layout for the column
Column _buildButtonColumn(Color color, IconData icon, String label, Function action){
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        color: color,
        onPressed: () { action(); },
        icon: Icon(icon),
      ),
      Container(
        margin: const EdgeInsets.only(top:8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),

    ],
  );
}


// #docregion FavoriteWidget
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}
// #enddocregion FavoriteWidget

// #docregion _FavoriteWidgetState, _FavoriteWidgetState-fields, _FavoriteWidgetState-build
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // #enddocregion _FavoriteWidgetState-build
  bool _isFavorited = true;
  int _favoriteCount = 41;

  // #enddocregion _FavoriteWidgetState-fields

  // #docregion _toggleFavorite
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  // #enddocregion _toggleFavorite

  // #docregion _FavoriteWidgetState-build
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
// #docregion _FavoriteWidgetState-fields
}

void callAction(){
  FlutterPhoneDirectCaller.callNumber("+16473541234");
}
void routeAction() {
  MapUtils.openMap(46.4968877641299, 7.683623355607833);
}
void shareAction(){
  Share.share('Oeschinen Lake Campground');
}

