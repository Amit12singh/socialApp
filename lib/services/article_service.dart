import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/response_model.dart';

import 'package:myapp/graphql/mutations.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<bool> createPost(ArticleModel map) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(CREATE_ARTICLE),
          variables: {
            "data": {"title": map.title, "madia": map.media},
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }

      Map? res = result.data?["crateArticle"];

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
