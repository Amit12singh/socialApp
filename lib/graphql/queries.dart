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
query Query(\$data: PaginationArgs!) {
  getAllUser(data: \$data) {
    data {
      createdAt
      currentCity
      email
      fullName
      house
      houseNumber
      id
      phoneNumber
      profession
      profileImage {
        mimeType
        id
        createdAt
        name
        path
        type
      }
      yearPassedOut
    }
    message
    status
    success
  }
}
""";

const GET_RECENT_CHATS = """
query GetRecentChatsForUser(\$userId: String!) {
  getRecentChatsForUser(userId: \$userId) {
    createdAt
    deletedAt
    id
    text
    updatedAt
    receiver {
      id
      fullName
      profileImage {
        name
        mimeType
        path
        id
        type
      }
      email
    }
    sender {
      id
      fullName
      email
      profileImage {
        path
        name
        mimeType
        id
        type
      }
    }
  }
}

""";


const ALL_CHATS = """
query GetMessages(\$sender: String!, \$receiver: String!) {
  getMessages(sender: \$sender, receiver: \$receiver) {
    sender {
      id
      fullName
      email
    }
    receiver {
      id
      fullName
      email
    }
    id
    text
    createdAt
  }
}

""";



const lastChatsBySender = """
query GetResentChat(\$sender: String!) {
  getResentChat(sender: \$sender) {
    id
    text
    sender {
      id
      email
      fullName
    }
    receiver {
      id
      fullName
      email
    }
    createdAt
  }
}
""";
