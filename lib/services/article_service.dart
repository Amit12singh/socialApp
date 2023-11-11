import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/pagination_model.dart';
import 'package:myapp/models/response_model.dart';
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
                };
              }).toList(),
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> likePost(String articleId) async {
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
        throw Exception(result.exception);
      }
      // Map? res = result.data?["createArticle"];

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<ArticleModel>> getArticles({
    PaginationModel? data,
  }) async {
    try {
      QueryResult result = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GET_ALL_POSTS),
        variables: {
          'data': {
            "page": data?.page ?? null,
            "perPage": data?.perPage ?? null,
            "search": data?.search
          },
        },
      ));


      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List res = result.data?['getAllArticles']?['data'];
      

        List<ArticleModel> articles =
            res.map((article) => ArticleModel.fromJson(article)).toList();
        return articles;
      }
    } catch (error) {
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
        throw Exception(result.exception);
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updatePost(String title, List mediaList,
      List<String> deletedMedia, String id) async {
    try {
      List<http.MultipartFile> _multipartFileList = [];

      List<ProfilePicture> _responseMediaList = [];

      if (mediaList.isNotEmpty) {
        _multipartFileList =
            await mediaConvert.convertMediaListToMultipart(mediaList);

        _responseMediaList =
            await mediaService.uploadMultipleImages(_multipartFileList);
      }

      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(UPDATE_ARTICLE),
          variables: {
            "data": {
              "deletedMedia": deletedMedia,
              "id": id,
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
        throw Exception(result.exception);
      }

      return true;
    } catch (error) {
      return false;
    }
  }



  Future<BoolResponseModel> addComment(String articleId, String comment) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            document: gql(ADD_COMMENT),
            variables: {
              "data": {"articleId": articleId.toString(), "comment": comment}
            }),
      );

      if (result.hasException) {
        return BoolResponseModel(
            message: result?.exception?.graphqlErrors[0].message ??
                'Something went wrong.',
            success: false,
            isError: true);
      }


      final response = result.data?['addComment'];
      if (response != null) {
        return BoolResponseModel(
            message: "Profile updated successfully",
            success: true,
            isError: false);
      } else {
        return BoolResponseModel(
            message: 'Something went wrong.', success: false, isError: true);
      }
    } catch (error) {
      return BoolResponseModel(
          message: 'Something went wrong.', success: false, isError: true);
    }
  }

}
