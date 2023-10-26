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
        print('create exeption');
        print(result);
        throw Exception(result.exception);
      }

      print('like Result $result');

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> likePost(String articleId) async {
    print(articleId);
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(LIKE_POST),
          variables: {
            "data": {"articleId": articleId},
          },
        ),
      );

      if (result.hasException) {
        print('exeption');
        print(result.exception);
        throw Exception(result.exception);
      }
      // Map? res = result.data?["createArticle"];

      return true;
    } catch (error) {
      print('like cattch $error');
      return false;
    }
  }

  Future<List> getArticles({
    PaginationModel? data,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(GET_ALL_POSTS),
          variables: {
            'data': {
              "page": data?.page ?? null,
              "perPage": data?.perPage ?? null,
              "search": data?.search
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List res = result.data?['getAllArticles']?['data'];
        print(res);

        List articles =
            res.map((article) => ArticleModel.fromJson(article)).toList();

        return articles;
      }
    } catch (error) {
      print('article service catch $error');
      return [];
    }
  }


  Future<bool> deleteArticle(String articleId) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document:
              gql(DELETE_ARTICLE), // Define your GraphQL mutation for deletion
          variables: {
            "data": {"id": articleId}
          },
        ),
      );

      if (result.hasException) {
        print('delete article exception');
        print(result.exception);
        throw Exception(result.exception);
      }

      print('delete article result $result');

      return true;
    } catch (error) {
      print('delete article catch $error');
      return false;
    }
  }

}
