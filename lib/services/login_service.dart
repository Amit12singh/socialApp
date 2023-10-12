import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/models/user_model.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<bool> login({required String email, required String password}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
          mutation Mutation(\$data: UserLoginInput!) {
          login(data: \$data) {
                accessToken
                email
                fullName
                id
                message
                profileImage {
                      name
                      path
                      type
                      id
                      mimeType
                     }
                    }
                }

          """),
          variables: {
            "data": {email, password},
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        print(result);
        return true;
      }
    } catch (error) {
      return false;
    }
  }
}
