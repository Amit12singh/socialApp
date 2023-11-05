import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myapp/config/graphql_config.dart';
import 'package:myapp/graphql/queries.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/graphql/mutations.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static HandleToken handleTokenService = HandleToken();
  GraphQLClient client = graphQLConfig.clientToQuery();


  Future<bool> forgotPasswordFunc(String email) async {
    print(email);

    BoolResponseModel response = await this.forgotPassword(email: email);
    print(response);
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<BoolResponseModel> login(
      {required String email, required String password, context}) async {
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
        BoolResponseModel response = BoolResponseModel(
            message: result?.exception?.graphqlErrors[0].message ??
                'Something went wrong.',
            success: false,
            isError: true);
        return response;
      }

      Map? res = result.data?["login"];

      final isSaved = await handleTokenService.saveAccessToken(res);
      if (isSaved) {
        return BoolResponseModel(
            message: 'Successfully logged in.', success: true, isError: false);
      } else {
        return BoolResponseModel(
            message: 'Something went wrong.', success: false, isError: true);
      }
    } catch (error) {
      return BoolResponseModel(
          message: 'Something went wrong.', success: false, isError: true);
    }
  }

  Future<BoolResponseModel> registerUser({
    required String fullName,
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
        BoolResponseModel response = BoolResponseModel(
            message: result?.exception?.graphqlErrors[0].message ??
                'Something went wrong.',
            success: false,
            isError: true);
        return response;
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
          message: 'Something went wrong.', success: false, isError: true);
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
            'data': {"page": null, "perPage": null, "search": search},
          },
        ),
      );

      if (result.hasException) {
        throw Exception(
            {"message": result?.exception?.graphqlErrors[0].message});
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

  Future<bool> vefifyEmail({required String otp}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(VERIFY_EMAIL),
          variables: {
            "otp": otp,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(
            {"message": result?.exception?.graphqlErrors[0].message});
      }
      final data = result.data?['confirmEmail'];
      print(data);
      return data;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<BoolResponseModel> forgotPassword({required String email}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            document: gql(FORGOT_PASSWORD),
            variables: {
              "data": {"email": email}
            }),
      );
      print(result);
      if (result.hasException) {
        BoolResponseModel response = BoolResponseModel(
            message: result?.exception?.graphqlErrors[0].message ??
                'Something went wrong.',
            success: false,
            isError: true);
        return response;
      }

      final res = result.data?["forgetPassword"];

      if (res == true) {
        return BoolResponseModel(
            message: 'Reset token sent to $email',
            success: true,
            isError: false);
      } else {
        return BoolResponseModel(
            message: "Something went wrong.Try again a few moment later",
            success: false,
            isError: true);
      }
    } catch (error) {
      return BoolResponseModel(
          message: "Something went wrong.Try again a few moment later",
          success: false,
          isError: true);
    }
  }

  Future<BoolResponseModel> resetPass(
      {required String password, required otp}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          document: gql(RESET_PASS),
          variables: {"newPassword": password, "resetToken": otp},
        ),
      );

      if (result.hasException) {
        return BoolResponseModel(
            message: result?.exception?.graphqlErrors[0].message ??
                'Something went wrong.',
            success: false,
            isError: true);
      }

      final response = result.data?['resetPassword'];
      if (response) {
        return BoolResponseModel(
          message: "Password updated successfully",
          success: true,
          isError: false);
      } else {
        return BoolResponseModel(
            message: 'Something went wrong.', success: false, isError: true);
      }
     
    } catch (error) {
      return BoolResponseModel(
          message: 'Something went wrong.', success: false, isError: true);
    }
  }

}
