import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haider/utills/customColors.dart';

import '../../controllers/rentAndRentOutController.dart';
import '../../utills/chatutlies.dart';
import 'chats.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            // more filter in data base
            final filteredUsers = snapshot.data!
                .where((user) =>
                    user.firstName ==
                    Get.put(RentAndRentOutController()).username.value)
                .toList();

            return ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                // var user = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    _handlePressed(filteredUsers[index], context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      color: CustomColors.blue_color,
                    ),
                    child: Center(
                      child: FaIcon(
                        color: Colors.white,
                        FontAwesomeIcons.whatsapp,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
