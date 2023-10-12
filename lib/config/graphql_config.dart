import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    "https://apis.oldnabhaite.site/oldnabhaiteapis/",
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      // Implement the logic to retrieve your authentication token here.
      // You can get it from a secure storage or any other source.
      // For example, if you're using JWT, you might store it in a shared preference.
      final token = '';
      return 'BEARER $token'; // Assuming your token is of the form "Bearer <token>"
    },
  );

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink.concat(authLink),
      );
}
