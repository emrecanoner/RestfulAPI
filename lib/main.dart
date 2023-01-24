import 'package:flutter/material.dart';
import 'package:restfull_api/models/user_model.dart';
import 'package:restfull_api/services/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();

  List<UsersModelData?> users = [];
  bool? isLoading;

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restfull Api',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Restfull Api'),
          ),
          body: isLoading == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : isLoading == true
                  ? ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${users[index]!.firstName! + users[index]!.lastName!}'),
                          subtitle: Text(users[index]!.email!),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index]!.avatar!),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Hata'),
                    )),
    );
  }
}
