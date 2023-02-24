import 'package:flutter/material.dart';

import '../common/components/loader.dart';
import '../features/users/api.dart';
import '../features/users/components/organisms/user_detail.dart';
import '../features/users/models/user.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    User userResponse = await UserApi().getMyself();

    setState(() {
      currentUser = userResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Mon compte'),
          ),
          body: Loader()
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon compte'),
      ),
      body: UserDetail(currentUser!),
    );
  }
}
