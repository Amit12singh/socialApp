import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/utilities/localstorage.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static HandleToken handleTokenService = HandleToken();
  GraphQLClient client = graphQLConfig.clientToQuery();


  Future<bool> login({required String email, required String password}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql("""
          mutation Mutation(\$data: UserLoginInput!) {
  login(data: \$data) {
    email
    fullName
    id
    message
    role
    accessToken
  }
}

          """),
          variables: {
            "data": {"email": email, "password": password},
          },
        ),
      );
      if (result.hasException) {

        throw Exception(result.exception);
      }

      Map? res = result?.data?['login'];

      final isTokenSaved =
          await handleTokenService.saveAccessToken(res?['accessToken']);

      print(handleTokenService.getAccessToken());
        return true;
      
    } catch (error) {
      return false;
    }
  }
}
