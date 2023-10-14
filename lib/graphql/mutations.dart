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
      email
      fullName
      id
      profileImage {
        id
        mimeType
        name
        path
        type
      }
      role
      deletedAt
      createdAt
      updatedAt
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
    body
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
