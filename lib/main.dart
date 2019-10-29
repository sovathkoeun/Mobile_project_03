import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
  

void main() => runApp(UserProfile());
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map profile;
  List userProfile;
  Future getProfile() async{
    http.Response response = await http.get('https://reqres.in/api/users?page=2');
    profile = json.decode(response.body);
    setState(() {
     userProfile = profile['data']; 
    });
  }
@override
  void initState() {
    super.initState();
    getProfile();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(  
        appBar: AppBar(  
          title: Text("User Profile"),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: userProfile == null ? 0 : userProfile.length,
          itemBuilder: (context, i){
            final user = userProfile[i];
            return Card(
              child: Column(  
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar( 
                       backgroundImage: NetworkImage(user['avatar']),
                       radius: 40.0,
                    ),
                  ), 
                  Padding( 
                     
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: CircleAvatar(  
                          //   backgroundColor: NetworkImage(user['avatar']),
                          // ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("${user['first_name']}, ${user['last_name']}",
                            style:TextStyle(  
                            fontSize: 20.0,
                             color: Colors.pink,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ),
                 
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}