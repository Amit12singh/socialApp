import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/models/article_model.dart';
import 'package:image_picker/image_picker.dart';


import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/media_service.dart';

class PostService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  final MediaService mediaService = MediaService();

  Future<bool> createPost(String title, List<XFile> mediaList) async {
    try {

      List<ProfilePicture>? _responseMediaList = [];

      if (mediaList.isNotEmpty) {
        _responseMediaList = await mediaService.uploadMultipleImages(mediaList);
      }
      print(
          "🚀 ~ file: article_service.dart:24 ~ PostService ~ Future<bool>createPost ~ $_responseMediaList:");

        

      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(CREATE_ARTICLE),
          variables: {
            "data": {"title": title, "madia": _responseMediaList},
          },
        ),
      );
      if (result.hasException) {
        print('here exeption');
        throw Exception(result.exception);
      }

      Map? res = result.data?["crateArticle"];
      print('here exeption $res');

      if (res?['success']) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
