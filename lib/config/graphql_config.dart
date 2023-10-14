import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';
import 'package:myapp/utilities/localstorage.dart';

class GraphQLConfig {
  static HandleToken handleTokenService = HandleToken();

  final token = handleTokenService.getAccessToken();

  final HttpLink httpLink = HttpLink(
    "http://127.0.0.1:8000",
  );

  final AuthLink authLink = AuthLink(getToken: () async => 'BEARER \$token');

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: authLink.concat(httpLink),
      );
}
