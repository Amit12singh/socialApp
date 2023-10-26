import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:intl/intl.dart';

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
}
