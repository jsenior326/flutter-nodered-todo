import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_client.dart';

final GraphQLClient gqlClient = initGraphQlClient();

// Query to get our todo list from the backend
Future<List<Map<String, dynamic>>> fetchTodoList() async {
  // GraphQL query to get todo list
  const String query = """
    query {
      getTodoList {
        id
        title
        description
        completed
      }
    }
  """;
  
  try{
    // Execute query
    final result = await gqlClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.noCache,
      )
    );

    return List<Map<String, dynamic>>.from(result.data?['getTodoList'] ?? []);
  } catch (e) {
    print("Error fetching todo list: $e");
    return [];
  }
}

// Mutation to add a new task
Future<void> addTask(Map<String, dynamic> newTask) async {
  // Mutation string for adding a task
  String mutation = """
    mutation {
      addTask(title: "${newTask['title']}", description: "${newTask['description'] ?? ''}") {
        id
        title
        description
        completed
      }
    }
  """;

  try {
    // Run mutation to add task
    final result = await gqlClient.mutate(
      MutationOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    // Check if there was an exception during the mutation
    if (result.hasException) {
      print("Error adding task: ${result.exception.toString()}");
    }
  } catch (e) {
    print("Exception occurred while adding task: $e");
  }
}

// Mutation to update an existing task
Future<void> updateTask(Map<String, dynamic> updatedTask) async {
  // Mutation string for updating task
  String mutation = """
    mutation {
      updateTask(id: "${updatedTask['id']}", title: "${updatedTask['title']}", description: "${updatedTask['description']}", completed: ${updatedTask['completed']}) {
        id
        title
        description
        completed
      }
    }
  """;

  try {
    // Run mutation to update task
    final result = await gqlClient.mutate(
      MutationOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    // Check for exception during update
    if (result.hasException) {
      print("Error updating task: ${result.exception.toString()}");
    }
  } catch (e) {
    print("Exception thrown while updating task: $e");
  }
}

// Mutation to delete an existing task
Future<void> deleteTask(String taskId) async {
  // Mutation string to delete task
  String mutation = """
    mutation {
      deleteTask(id: "$taskId")
    }
  """;

  try {
    // Run mutation to delete task
    final result = await gqlClient.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {'id': taskId},
      ),
    );

    if (result.hasException) {
      print("Error deleting task: ${result.exception.toString()}");
    }
  } catch (e) {
    print("Error thrown while deleting task: $e");
  }
}