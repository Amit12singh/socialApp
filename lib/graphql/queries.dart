const GET_ALL_POSTS = """
        query GetAllArticles(\$data: PaginationArgs!) {
  getAllArticles(data: \$data) {
    data {
      body
      id
      likes {
        id
        article {
          id
        }
        user {
          id
          profileImage {
            path
            name
            mimeType
            type
            id
            deletedAt
          }
        }
      }
      owner {
        profileImage {
          type
          path
          name
          mimeType
          id
        }
        id
        fullName
        email
      }
      title
      createdAt
      deletedAt
      media {
        id
        mimeType
        name
        path
        type
        deletedAt
        createdAt
        updatedAt
      }
    }
    pagination {
      nextPage
      perPage
      total
      totalPages
      prevPage
    }
  }
}
""";
