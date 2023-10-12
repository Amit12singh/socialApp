import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';
import 'package:myapp/utilities/localstorage.dart';

class GraphQLConfig {
  HandleToken? tokenService;
  String? token;

  GraphQLConfig() {
    tokenService = HandleToken();
    token = '';
  }

  Future<String?> initializeToken() async {
    return await tokenService?.getAccessToken();
  }

  final HttpLink httpLink = HttpLink(
    "https://apis.oldnabhaite.site/oldnabhaiteapis",
  );

  // final AuthLink authLink = AuthLink(getToken: () async => 'BEARER $initializeToken()');

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );
}
