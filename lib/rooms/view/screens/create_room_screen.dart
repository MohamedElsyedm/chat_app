import 'package:chat_app/auth/presentation/widgets/default_elevated_button.dart';
import 'package:chat_app/auth/presentation/widgets/default_text_form_field.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/core/ui_utils.dart';
import 'package:chat_app/core/validator.dart';
import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:chat_app/rooms/view/widgets/categories_dropdown_button.dart';
import 'package:chat_app/rooms/view_model/rooms_state.dart';
import 'package:chat_app/rooms/view_model/rooms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomScreen extends StatefulWidget {
  static const routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  String? selectedCategoryId;
  final formKey = GlobalKey<FormState>();
  final viewModel = RoomsViewModel();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 36),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: size.height * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    color: AppTheme.white,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create New Room',
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/group_.png',
                            height: size.height * 0.12,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 24),
                          DefaultTextFormField(
                            hintText: 'Room Name',
                            controller: nameController,
                            validator: (value) =>
                                Validator.validateUsername(value),
                          ),
                          const SizedBox(height: 24),
                          CategoriesDropdownButton(
                            onCategorySelected: (categoryId) {
                              selectedCategoryId = categoryId;
                            },
                          ),
                          const SizedBox(height: 24),
                          DefaultTextFormField(
                            hintText: 'Room Description',
                            maxLines: 3,
                            controller: descController,
                            validator: (value) =>
                                Validator.validateFullName(value),
                          ),
                          const SizedBox(height: 36),
                          BlocListener<RoomsViewModel, RoomsState>(
                            listener: (context, state) {
                              if (state is CreateRoomsLoading) {
                                UiUtils.showLoading(context);
                              } else if (state is CreateRoomsSuccess) {
                                Navigator.pop(context);
                                UiUtils.showSuccessMessage(
                                  'Room created successfully',
                                );
                                Navigator.pop(context);
                              } else if (state is CreateRoomsError) {
                                Navigator.pop(context);
                                UiUtils.showErrorMessage(state.errorMessage);
                              }
                            },
                            child: DefaultElevatedButton(
                              label: 'Create',
                              width: size.width * 0.7,
                              borderRadiusValue: 32,
                              onPressed: createRoom,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createRoom() {
    if (formKey.currentState!.validate()) {
      viewModel.createRoom(
        RoomModel(
          name: nameController.text,
          description: descController.text,
          categoryId: selectedCategoryId!,
        ),
      );
    }
  }
}
