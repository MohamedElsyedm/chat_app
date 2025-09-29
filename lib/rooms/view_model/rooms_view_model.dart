import 'package:chat_app/core/database_utils.dart';
import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:chat_app/rooms/view_model/rooms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsViewModel extends Cubit<RoomsState> {
  RoomsViewModel() : super(RoomsInitial());

  List<RoomModel> rooms = [];

  //get rooms
  Future<void> getRooms() async {
    emit(GetRoomsLoading());
    try {
      rooms = await DatabaseUtils.getRoom();
      emit(GetRoomsSuccess(rooms));
      print(rooms.length);
    } catch (exception) {
      emit(GetRoomsError(exception.toString()));
    }
  }

  //create room
  Future<void> createRoom(RoomModel room) async {
    emit(CreateRoomsLoading());
    try {
      await DatabaseUtils.createRoom(room);
      emit(CreateRoomsSuccess());
    } catch (exception) {
      emit(CreateRoomsError(exception.toString()));
    }
  }
}
