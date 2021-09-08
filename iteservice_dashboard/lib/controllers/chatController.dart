import 'package:get/get.dart';
import 'package:iteservice_dashboard/models/models.dart';
import 'package:iteservice_dashboard/services/firebaseApi.dart';

class ChatController extends GetxController {

  final Rx<List<ChatUser>> _chatUserList = Rx<List<ChatUser>>([]);

  List<ChatUser> get chatUserList => _chatUserList.value;

  @override
  void onInit() {
    _chatUserList.bindStream(FirebaseApi.getAllChats());
    super.onInit();
  }

  Future<void> setLastMessage(ChatUser chatUser, String message) async {
    ChatUser upChatUser = ChatUser(
      id: chatUser.id,
      name: chatUser.name,
      lastMessage: message,
      profileImg: chatUser.profileImg,
      updateDate: DateTime.now()
    );
    await FirebaseApi.updateChatUser(upChatUser);
  }

}