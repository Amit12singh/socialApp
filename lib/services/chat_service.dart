import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class ChatService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  ProfilePicture convertToMultipartService = ProfilePicture();

  Future<List> recentChat({
    String? userId,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(GET_RECENT_CHATS),
          variables: {'userId': userId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List res = result.data?['getRecentChatsForUser'];
        print(res);

        List<ChatModel> recentChats = res.map((chat) {
          if (chat?["sender"]?["id"] != userId) {
            return ChatModel(
              id: chat?["sender"]?["id"],
              text: chat?["text"],
              avatarImage: chat?["sender"]?["profileImage"]?["path"],
              name: chat?["sender"]?["fullName"],
              time: DateFormat.Hm()
                  .format(DateTime.parse(chat['createdAt']))
                  .toString(),
            );
          } else {
            return ChatModel(
              id: chat?["receiver"]?["id"],
              text: chat?["text"],
              avatarImage: chat?["receiver"]?["profileImage"]?["path"],
              name: chat?["receiver"]?["fullName"],
              time: DateFormat.Hm()
                  .format(DateTime.parse(chat['createdAt']))
                  .toString(),
            );
          }
        }).toList();
        print(recentChats);

        return recentChats;
      }
    } catch (error) {
      print('article service catch $error');
      return [];
    }




    
  }

  Future<List<types.TextMessage>> allChats(
      {String? sender, String? receiver}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(ALL_CHATS),
          variables: {"sender": sender, "receiver": receiver},
        ),
      );

      if (result.hasException) {
        print('exeption');
        throw Exception(result.exception);
      } else {
        List res = result.data?['getMessages'];
        print(res);

        List<types.TextMessage> chats = res.map((chat) {
          print(chat['id']);

          return types.TextMessage(
              author: types.User(id: chat['sender']?['id']),
              id: chat['id'],
              text: chat['text']);
        }).toList();

        print(chats);

        return chats;
      }
    } catch (error) {
      print('chats service catch $error');
      return [];
    }
  }


  Future<bool> sendMessage(String text, String receiver) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(SEND_MESSAGE),
          variables: {
            "data": {
              "text": text,
              "receiverID": receiver,
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      Map res = result.data?['sendMessage'];

      if (res != null) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  
}
