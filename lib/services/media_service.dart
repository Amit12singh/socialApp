import 'package:myapp/config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<ProfilePicture>> uploadMultipleImages(
      List<XFile> mediaList) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(UPLOAD_MULTIPLE_FILE),
            variables: {"files": mediaList}),
      );

      if (result.hasException) {
        print(result.exception);
        throw Exception(result.exception);
      } else {
        print(result);
        List dataList = result.data?['multipleFileUpload'];
        List<ProfilePicture> media = dataList
            .map((media) => ProfilePicture.fromMap(map: media))
            .toList();

        return media;
      }
    } catch (err) {
      return [];
    }
  }
}
