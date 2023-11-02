const LOGIN_USER = """
          mutation Mutation(\$data: UserLoginInput!) {
  login(data: \$data) {
    email
    fullName
    id
    message
    role
    accessToken
  }
}

          """;

const CREATE_USER = """ 
mutation Mutation(\$data: RegisterInput!) {
  createUser(data: \$data) {
    data {
      createdAt
      currentCity
      email
      fullName
      house
      id
      houseNumber
      phoneNumber
      profession
      profileImage {
        id
        mimeType
        name
        path
        type
        createdAt
      }
      role
      yearPassedOut
    }
    message
    status
    success
  }
}
""";

const CREATE_ARTICLE = """
mutation CreateArticle(\$data: ArticleInput!) {
  createArticle(data: \$data) {
    title
    createdAt
    deletedAt
    id
    media {
      mimeType
      id
      deletedAt
      createdAt
      name
      path
      type
      updatedAt
    }
    owner {
      id
      fullName
      email
      profileImage {
        id
        mimeType
        name
        path
        type
      }
      role
    }
  }
}
 """;

const UPLOAD_MULTIPLE_FILE = """
mutation Mutation(\$type: mediaType!, \$files: [Upload!]!) {
  multipleUpload(type: \$type, files: \$files) {
    mimeType
    name
    type
  }
}
""";

const LIKE_POST = """
mutation Mutation(\$data: likeInput!) {
  articleLike(data: \$data)
}
""";

const DELETE_ARTICLE = """
mutation Mutation(\$data: IDInput!) {
  deleteArticle(data: \$data) {
    message
    status
    success
  }
}

 """;


const UPDATE_ARTICLE = """
mutation Mutation(\$data: ArticleUpdateInput!) {
  UpdateArtice(data: \$data) {
    id
    likes {
      id
      user {
        id
        email
        fullName
      }
      createdAt
    }
    media {
      mimeType
      name
      path
      type
      createdAt
    }
    title

  }
}
""";

const SEND_MESSAGE = """
mutation Mutation(\$data: MessageInput!) {
  sendMessage(data: \$data) {
    id
    receiver {
      id
      fullName
      email
    }
    sender {
      id
      fullName
      email
    }
    text
    createdAt
  }
}
""";

const VERIFY_EMAIL = """
mutation Mutation(\$otp: String!) {
  confirmEmail(otp: \$otp)
}
""";
