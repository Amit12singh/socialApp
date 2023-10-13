import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/graphql/mutations.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static HandleToken handleTokenService = HandleToken();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<bool> login({required String email, required String password}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(LOGIN_USER),
          variables: {
            "data": {"email": email, "password": password},
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }

      Map? res = result.data?["login"];

      final isSaved =
          await handleTokenService.saveAccessToken(res?['accessToken']);

      if (isSaved) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<BoolResponseModel> registerUser(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(CREATE_USER),
          variables: {
            "data": {
              "fullName": fullName,
              "email": email,
              "password": password
            },
          },
        ),
      );
      if (result.hasException) {

        throw Exception(result.exception);
      }

      final res = result.data?["createUser"];

      if (res?["success"] == true) {
        return BoolResponseModel(
            message: 'User registered SuccessFully!!', success: true);
      } else {
        return BoolResponseModel(
            message: 'User register failed!!', success: false);
      }
    } catch (error) {
      return BoolResponseModel(
          message: 'Something went wrong.', success: false);
    }
  }
}