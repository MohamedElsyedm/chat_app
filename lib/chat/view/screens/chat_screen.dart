import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/chat/data/model/message.dart';
import 'package:chat_app/chat/view/widgets/chat_bubble_widget.dart';
import 'package:chat_app/chat/view_model/chat_state.dart';
import 'package:chat_app/chat/view_model/chat_view_model.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/core/widgets/error_indicator.dart';
import 'package:chat_app/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final viewModel = ChatViewModel();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.roomId = ModalRoute.of(context)!.settings.arguments as String;
      viewModel.getMessageStream();
      viewModel.currentUser = BlocProvider.of<AuthViewModel>(
        context,
      ).currentUser!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text('Chat App'),
        forceMaterialTransparency: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_background_.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(top: MediaQuery.sizeOf(context).height * 0.1),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: size.height * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    color: AppTheme.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: BlocBuilder<ChatViewModel, ChatState>(
                            bloc: viewModel,
                            //builder is work in specific states only not all states
                            buildWhen: (previous, current) =>
                                current is GetMessagesStreamLoading ||
                                previous is GetMessagesStreamLoading,
                            builder: (context, state) {
                              if (state is GetMessagesStreamLoading) {
                                return const LoadingIndicator();
                              } else if (state is GetMessagesStreamError) {
                                return ErrorIndicator();
                              } else if (state is GetMessagesStreamSuccess) {
                                return StreamBuilder(
                                  stream: state.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      messages = snapshot.data!;
                                    }
                                    return ListView.builder(
                                      reverse: true,
                                      itemCount: messages.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (_, index) {
                                        final message = messages[index];
                                        final isMyMessage = viewModel
                                            .isMyMessage(message.senderId);
                                        return ChatBubble(
                                          isMyMessage: isMyMessage,
                                          message: message,
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: viewModel.messageController,
                                cursorColor: AppTheme.primary,
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 8),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppTheme.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                fixedSize: Size(80, 45),
                              ),
                              onPressed: () => viewModel.sendMessage(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Send'),
                                  SizedBox(width: 8),
                                  Icon(Icons.send, size: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
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
}
