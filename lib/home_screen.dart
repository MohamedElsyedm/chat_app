import 'package:chat_app/chat/view/screens/chat_screen.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/core/ui_utils.dart';
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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                      mainAxisExtent: 190,
                    ),

                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          UiUtils.showSuccessMessage(
                            'Double click to enter to the room',
                          );
                          currentIndex = index;
                          setState(() {});
                        },
                        onDoubleTap: () {
                          Navigator.of(context).pushNamed(
                            ChatScreen.routeName,
                            arguments: state.rooms[index].id,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: currentIndex == index
                                ? Border.all(color: AppTheme.grey, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: RoomItem(room: state.rooms[index]),
                        ),
                      );
                    },
                  );
                } else {
                  return LoadingIndicator();
                }
              },
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              onPressed: () {
                UiUtils.showLoading(context, [
                  Text(
                    'Are you want to delete selected room ?',
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppTheme.white,
                        ),
                        onPressed: () {
                          viewModel.deleteRoom(viewModel.rooms[currentIndex]);
                          UiUtils.showSuccessMessage(
                            'Room deleted successfully',
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                ]);
              },
              child: const Icon(Icons.delete, size: 36),
            ),
            SizedBox(height: 18),
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CreateRoomScreen.routeName,
                ).then((_) => viewModel.getRooms());
              },
              child: const Icon(Icons.add, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}
