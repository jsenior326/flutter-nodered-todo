import 'package:graphql_flutter/graphql_flutter.dart';

// Node-Red GraphQL endpoint
const String NODE_RED_URL = 'http://localhost:1880/graphql';

// Initialize the GraphQL client
GraphQLClient initGraphQlClient() {
  final HttpLink httpLink = HttpLink(NODE_RED_URL);

  return GraphQLClient(
    link: httpLink, 
    cache: GraphQLCache(store: InMemoryStore())
  );
}