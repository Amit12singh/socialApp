import 'package:myapp/config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/graphql/mutations.dart';
import 'package:myapp/models/user_model.dart';

class MediaService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  Future<List<ProfilePicture>> uploadMultipleImages(List mediaList) async {
    print('here media service $mediaList');

    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(UPLOAD_MULTIPLE_FILE),
            variables: {"files": mediaList, "type": "ARTICLE_IMAGE"}),
      );

      if (result.hasException) {
        print(result.exception);
        throw Exception(result.exception);
      } else {
        List dataList = result.data?['multipleUpload'];
        List<ProfilePicture> media =
            dataList.map((img) => ProfilePicture.fromMap(map: img)).toList();
        print("here media result $media");

        return media;
      }
    } catch (err) {
      return [];
    }
  }
}
