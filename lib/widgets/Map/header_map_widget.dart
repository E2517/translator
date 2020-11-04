import 'package:flutter/material.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/skater.png'),
          ),
          title: Text(
            'Carlos',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text('You have a new notitication',
              style: TextStyle(color: Colors.black)),
          trailing: Icon(
            Icons.map,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('map', (route) => false);
          },
        ),
      ),
    );
  }
}
