import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/alert_box.dart';
import 'package:social_app/components/bio_box.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({
    super.key,
    required this.uid
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final databaseProvider =
    Provider.of<DatabaseProvider>(context, listen: false);

  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();
  bool _isLoading = true;
  final bioTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);
    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => AlertBox(
        textController: bioTextController,
        hintText: "Edit bio",
        onPressed: saveBio,
        onPressedText: "Save"
      )
    );
  }

  Future<void> saveBio() async {
    setState(() {
      _isLoading = true;
    });
    await databaseProvider.updateBio(bioTextController.text);
    await loadUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(_isLoading ? '' : user!.name),
        foregroundColor: context.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: buildListView(context),
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: [
        buildUsernameView(context),
        const SizedBox(height: 25),
        buildProfileView(context),
        buildEditBioBoxView(context),
        const SizedBox(height: 10),
        BioBox(text: _isLoading ? '...' : user!.bio),
      ],
    );
  }

  Row buildEditBioBoxView(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bio",
            style: TextStyle(
              color: context.colorScheme.primary
            ),
          ),
          GestureDetector(
            onTap: _showEditBioBox,
            child: Icon(
              Icons.settings,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      );
  }

  Center buildProfileView(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(25),
          child: Icon(
            Icons.person,
            size: 72,
            color: context.colorScheme.primary,
          ),
        ),
      );
  }

  Center buildUsernameView(BuildContext context) {
    return Center(
        child: Text(
          _isLoading ? '' : '@${user!.username}',
          style: TextStyle(
            color: context.colorScheme.primary
          ),
        )
      );
  }
}
