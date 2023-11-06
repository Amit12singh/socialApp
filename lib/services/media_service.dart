import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/models/user_model.dart';

class MediaService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  Future<List<ProfilePicture>> uploadMultipleImages(List mediaList) async {

    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(UPLOAD_MULTIPLE_FILE),
            variables: {"files": mediaList, "type": "ARTICLE_IMAGE"}),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List dataList = result.data?['multipleUpload'];
        List<ProfilePicture> media =
            dataList.map((img) => ProfilePicture.fromMap(map: img)).toList();

        return media;
      }
    } catch (err) {
      return [];
    }
  }

  Future<ProfilePicture> uploadSingleImage(MultipartFile media, type) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(SINGLE_FILE_UPLOAD),
            variables: {"file": media, "type": type}),
      );
      


      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        final data = result.data?['singleUpload'];
        ProfilePicture media = ProfilePicture.fromMap(map: data);

        return media;
      }
    } catch (err) {
      return {} as ProfilePicture;
    }
  }
}
