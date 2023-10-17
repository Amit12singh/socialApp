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


const USER_PROFILE = """
query Me(\$userId: String!) {
  me(userId:\$userId) {
    TimeLine {
      title
      owner {
        id
        profileImage {
          id
          mimeType
          name
          path
          type
        }
        fullName
        email
        createdAt
        role
      }
      media {
        id
        mimeType
        name
        path
        type
      }
      id
      likes {
        id
        deletedAt
        createdAt
        user {
          id
          email
        }
      }
    }
    profile {
      email
      fullName
      id
      profileImage {
        mimeType
        id
        name
        path
        type
      }
      role
    }
    success
    totalLikes
    totalPosts
  }
}
""";
