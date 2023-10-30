import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/pagination_model.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/models/user_profile_model.dart';
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

      final isSaved = await handleTokenService.saveAccessToken(res);
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
    required String password,
    required String passedOutYear,
    required String house,
    required String houseNumber,
    required String currentCity,
    required String phoneNumber,
    required String profession,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(CREATE_USER),
          variables: {
            "data": {
              "fullName": fullName,
              "email": email,
              "password": password,
              "currentCity": currentCity,
              "house": house,
              "houseNumber": houseNumber,
              "phoneNumber": phoneNumber,
              "profession": profession,
              "yearPassedOut": passedOutYear

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

      if (res?["success"] == true) {
        final profile = UserTimelineModel.fromJson(res);
        return profile;
      } else {
        return null;

      }
    } catch (error) {
      return null;
    }
  }

  Future<List<UserModel>> getUsers({
    required String search,
  }) async {
   

    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(GET_ALL_USERS),
          variables: {
            'data': {
              "page": null,
              "perPage": null,
              "search": search 
            },
          },
        ),
      );



      if (result.hasException) {

        throw Exception(result.exception);
      } else {
        List res = result.data?['getAllUser']?['data'];

        List<UserModel> users =
            res.map((user) => UserModel.fromJson(user)).toList();

        return users;
      }
    } catch (error) {
      return [];
    }
  }


}
