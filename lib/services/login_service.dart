import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/utilities/localstorage.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static HandleToken handleTokenService = new HandleToken();
  GraphQLClient client = graphQLConfig.clientToQuery();


  Future<bool> login({required String email, required String password}) async {
    print(email);
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
        print(result.exception);

        throw Exception(result.exception);
      }

     
      Map? res = result?.data?["login"];

      final isSaved =
          await handleTokenService.saveAccessToken(res?['accessToken']);


      if (isSaved) {
        final token = await handleTokenService.getAccessToken();
        print('token is $token');
        return true;
      } else {
        return false;
      }
     
      
    } catch (error) {
      return false;
    }
  }
}
