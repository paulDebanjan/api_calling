import 'package:api_calling/components/profile_link_tile.dart';
import 'package:api_calling/components/profile_link_title_text.dart';
import 'package:api_calling/components/profile_task_tile.dart';
import 'package:api_calling/login.dart';
import 'package:api_calling/pages/settings_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  String _userName = 'Mathe Hays';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('lib/assets/man.jpg'),
              ),
              SizedBox(height: 10),
              Text(_userName, style: TextStyle(fontSize: 24)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileTaskTile(text: '5 Task done'),
                  SizedBox(width: 10),
                  ProfileTaskTile(text: '10 Task left'),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // settings
                ProfileLinkTitleText(text: 'Settings'),
                ProfileLinkTile(
                  iconData: Icons.settings,
                  text: 'App Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),

                // account
                ProfileLinkTitleText(text: 'Account'),
                ProfileLinkTile(
                  iconData: Icons.person,
                  text: 'Change account name',
                  onTap: () {},
                ),
                ProfileLinkTile(
                  iconData: Icons.key,
                  text: 'Change account password',
                  onTap: () {},
                ),
                ProfileLinkTile(
                  iconData: Icons.camera_alt_rounded,
                  text: 'Change account Image',
                  onTap: () {},
                ),

                // uptodo
                ProfileLinkTitleText(text: 'Uptodo'),
                ProfileLinkTile(
                  iconData: Icons.widgets_outlined,
                  text: 'About us',
                  onTap: () {},
                ),
                ProfileLinkTile(
                  iconData: Icons.info_outline,
                  text: 'FAQ',
                  onTap: () {},
                ),
                ProfileLinkTile(
                  iconData: Icons.flash_on,
                  text: 'Help & Feedback',
                  onTap: () {},
                ),
                ProfileLinkTile(
                  iconData: Icons.thumb_up_off_alt,
                  text: 'Support US',
                  onTap: () {},
                ),
                // logout
                InkWell(
                  onTap: () => logout(context),
                  child: Row(
                    children: [
                      Icon(Icons.login_rounded, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 21, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
