import 'package:atelier/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:atelier/data/dart_var.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {

  UserInfo( {Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {

  Future<User> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    User u;

    String? id = prefs.getString('idUser');
    String? token = prefs.getString('accessToken');

    String bearerAuth = 'Bearer ' + token!;

    Dio dio = new Dio();
    Response r = await dio.get(data.apiuser + '/' + id!, options: Options(
        headers: <String, String>{
          'authorization': bearerAuth
        }
    ));


    if(r.statusCode == 200) {
      u = User(userId: id, choice: 0, firstname: r.data['user']['firstname'], lastname: r.data['user']['lastname']);
    } else {
      u = User(userId: 'Beug', choice: 0, firstname: 'beug', lastname: 'beug');
    }

    return u;



  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
              future: getUserInfo(),
              builder: (context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            RichText(
                                text: const TextSpan(
                                    text: 'Vous êtes connecté en temps que :',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                    ))),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(snapshot.data!.firstname + ' ' + snapshot.data!.lastname),
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                      itemCount: 1
                  );
                } else {
                  return Text('No data found');
                }
              }),
        )
      ],
    );
  }
}
