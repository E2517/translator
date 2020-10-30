import 'package:flutter/material.dart';
import 'package:translator/database/sqlite_database.dart';

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
          subtitle: FutureBuilder(
            future: SQLiteDatabase.db.getAllLanguages(),
            builder: (context, snapshot) {
              List<Languages> data = snapshot.data ?? [];
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Languages lang = data[index];
                  return Text(lang.english,
                      style: TextStyle(color: Colors.black));
                },
              );
            },
          ),
          trailing: Icon(
            Icons.g_translate,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('home', (route) => false);
          },
        ),
      ),
    );
  }
}
