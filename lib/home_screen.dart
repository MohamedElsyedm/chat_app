import 'package:chat_app/core/widgets/error_indicator.dart';
import 'package:chat_app/core/widgets/loading_indicator.dart';
import 'package:chat_app/rooms/view/screens/create_room_screen.dart';
import 'package:chat_app/rooms/view/widgets/room_item.dart';
import 'package:chat_app/rooms/view_model/rooms_state.dart';
import 'package:chat_app/rooms/view_model/rooms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = RoomsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
            child: BlocBuilder<RoomsViewModel, RoomsState>(
              builder: (context, state) {
                if (state is GetRoomsLoading) {
                  return LoadingIndicator();
                } else if (state is GetRoomsError) {
                  return ErrorIndicator(errorMessage: state.errorMessage);
                } else if (state is GetRoomsSuccess) {
                  return GridView.builder(
                    itemCount: state.rooms.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 180,
                    ),
                    itemBuilder: (context, index) {
                      return RoomItem(room: state.rooms[index]);
                    },
                  );
                } else {
                  return LoadingIndicator();
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CreateRoomScreen.routeName,
            ).then((_) => viewModel.getRooms());
          },
          child: const Icon(Icons.add, size: 36),
        ),
      ),
    );
  }
}
