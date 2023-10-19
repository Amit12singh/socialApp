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
        deletedAt
        createdAt
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
         deletedAt
        createdAt
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
          fullName
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
    }
    success
    totalLikes
    totalPosts
  }
}
""";


const GET_ALL_USERS = """
query GetAllUser(\$data: PaginationArgs!) {
  getAllUser(data: \$data) {
    data {
      createdAt
      deletedAt
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
    message
    status
    success
  }
}

""";
