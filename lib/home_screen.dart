import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/rooms/view/screens/room_screen.dart';
import 'package:chat_app/rooms/view/widgets/room_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Chat App')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_background_.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 180,
            ),
            itemBuilder: (context, index) {
              return RoomItem();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateRoomScreen.routeName);
        },
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }
}
