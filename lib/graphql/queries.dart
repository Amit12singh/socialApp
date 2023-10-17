const GET_ALL_POSTS = """
       query GetAllArticles(\$data: PaginationArgs!) {
  getAllArticles(data: \$data) {
    data {
      id
      likes {
        id
        user {
          id
          fullName
          email
        }
      }
      media {
        mimeType
        name
        path
        type
        id
      }
      owner {
        id
        profileImage {
          mimeType
          name
          path
          type
          id
        }
        role
        email
        fullName
        createdAt
      }
      title
      createdAt
    }
    message
    status
    success
  }
}
""";
