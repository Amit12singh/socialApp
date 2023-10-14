const GET_ALL_POSTS = """
         query GetAllArticles(\$data: PaginationArgs!) {
  getAllArticles(data: \$data) {
    data {
      id
      createdAt
      likes {
        id
        isLiked
        user {
          id
          email
        }
        article {
          id
        }
      }
      owner {
        id
        fullName
        profileImage {
          id
          mimeType
          path
          name
          type
        }
      }
      title
      updatedAt
    }
    message
    status
    success
    pagination {
      nextPage
      perPage
      prevPage
      total
      totalPages
    }
  }
} """;
