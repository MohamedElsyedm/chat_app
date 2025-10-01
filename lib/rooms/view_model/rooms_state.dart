import 'package:chat_app/rooms/data/models/room_model.dart';

abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class GetRoomsLoading extends RoomsState {}

class GetRoomsSuccess extends RoomsState {
  final List<RoomModel> rooms;
  GetRoomsSuccess(this.rooms);
}

class GetRoomsError extends RoomsState {
  final String errorMessage;
  GetRoomsError(this.errorMessage);
}

class CreateRoomsLoading extends RoomsState {}

class CreateRoomsSuccess extends RoomsState {}

class CreateRoomsError extends RoomsState {
  final String errorMessage;
  CreateRoomsError(this.errorMessage);
}

class DeleteRoomsLoading extends RoomsState {}

class DeleteRoomsSuccess extends RoomsState {}

class DeleteRoomsError extends RoomsState {
  final String errorMessage;
  DeleteRoomsError(this.errorMessage);
}
