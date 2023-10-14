import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';
import 'package:myapp/utilities/localstorage.dart';

class GraphQLConfig {
  final HandleToken handleTokenService = HandleToken();

  Future<String?> getToken() async {
    return await handleTokenService.getAccessToken();
  }

  AuthLink _authLink() {
    final link = AuthLink(getToken: () async {
      final token = await getToken();
      return 'BEARER $token';
    });

    return link;
  }

  final HttpLink _httpLink = HttpLink(
    "https://apis.oldnabhaite.site/oldnabhaiteapis",
  );

  GraphQLClient clientToQuery() {
    final link = _authLink().concat(_httpLink);
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
