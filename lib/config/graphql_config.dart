import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';

class GraphQLConfig {
  final HttpLink httpLink = HttpLink(
    "https://apis.oldnabhaite.site/oldnabhaiteapis",
  );

  // final AuthLink authLink = AuthLink(
  //   getToken: () async {
  //     final token = '';
  //     return 'BEARER token'; // Assuming your token is of the form "Bearer <token>"
  //   },
  // );

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );
}
