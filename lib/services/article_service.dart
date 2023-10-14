import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/pagination_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/media_service.dart';

class PostService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  ProfilePicture convertToMultipartService = ProfilePicture();

  final MediaService mediaService = MediaService();
  final ProfilePicture mediaConvert = new ProfilePicture();

  Future<bool> createPost(String title, List mediaList) async {
    try {
      List<http.MultipartFile> _multipartFileList = [];

      List<ProfilePicture> _responseMediaList = [];

      if (mediaList.isNotEmpty) {
        print('called meadia');

        _multipartFileList =
            await mediaConvert.convertMediaListToMultipart(mediaList);

        _responseMediaList =
            await mediaService.uploadMultipleImages(_multipartFileList);
      }

      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(CREATE_ARTICLE),
          variables: {
            "data": {
              "title": title,
              "body": "test body",
              "media": _responseMediaList.map((media) {
                return {
                  "type": media.type,
                  "mimeType": media.mimeType,
                  "name": media.name,
                  // You may need to implement this
                };
              }).toList(),
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      Map? res = result.data?["createArticle"];

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<ArticleModel>> getArticles({
    PaginationModel? data,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(GET_ALL_POSTS),
          variables: {
            'data': {
              "page": data?.page,
              "perPage": data?.perPage,
              "search": data?.search
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List res = result.data?['getAllArticles']?['data'];

        if (res == null || res.isEmpty) {
          return [];
        }

        List<ArticleModel> articles =
            res.map((article) => ArticleModel.fromMap(map: article)).toList();

        return articles;
      }
    } catch (error) {
      return [];
    }
  }
}
