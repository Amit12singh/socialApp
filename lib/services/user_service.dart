import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/graphql/mutations.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static HandleToken handleTokenService = HandleToken();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<bool> login({required String email, required String password}) async {
    print(email);

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
      print('here res $res');

      final isSaved = await handleTokenService.saveAccessToken(res);
      print('isSaved $isSaved');
      if (isSaved) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('here $error');
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


  Future<UserTimelineModel?> userProfile({required String id}) async {

    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            document: gql(USER_PROFILE),
            variables: {"userId": id}),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }

      final res = result.data?["me"];
      print('here exception $res');

      if (res?["success"] == true) {
        final profile = UserTimelineModel.fromJson(res);
        return profile;
      }
    } catch (error) {
      return null;
      print('here catch $error');
    }
  }

}
