const signUpQuery = '''
mutation SignupUser(\$SignupUserDto: SignUpDto!) {
signupUser(signupUserDto: \$SignupUserDto) {
firstName
lastName
fullName
phoneNumber
userStatus
isVerified
userType
userChat{
    id
    login
    password
    customData
  }
}
}''';

const signupUserByGoogle = '''
mutation signupUserByGoogle(
\$signupUserGoogle: SignupGoogleDto!
){
  signupUserByGoogle(signupUserGoogle:\$signupUserGoogle){
    
      firstName
      accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
lastName
fullName
phoneNumber
userStatus
isVerified
userType
    }}
      
''';
const signupUserByApple = '''
mutation signupUserByApple(
\$signupUserApple: SignupAppleDto!
){
  signupUserByApple(signupUserApple:\$signupUserApple){
   
      firstName
      accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
lastName
fullName
phoneNumber
userStatus
isVerified
userType
    }}
''';

const signupUserByFacebook = '''
mutation signupUserByFacebook(\$signupUserFacebook:SignupFacebookDto!){
  signupUserByFacebook(signupUserFacebook:\$signupUserFacebook){
    firstName
    accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
lastName
fullName
phoneNumber
userStatus
isVerified
userType
  }
}
''';
const verifyUserQuery = '''mutation VerifyUser(\$VerifyUserDto: VerifyUserDto!) {
    verifyUser(verifyUserDto: \$VerifyUserDto) {
      accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
    userType
    userStatus
    }
  }''';

const loginUserQuery = ''' mutation login(\$auth: LoginUserDto!) {
    login(auth: \$auth) {
      ... on LoginResponseDto{
         accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
    userType
    userStatus
    userChat{
      id
      login
      password
      customData
      }
      }
      ... on UserNotVerified{
        isVerified
        phoneNumber
      }
    }
  }
  ''';
const googleLogin = '''
mutation googleLogin(\$auth: LoginGoogleDto!) {
    googleLogin(auth: \$auth) {
      ... on LoginResponseDto{
         accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
    userType
    userStatus
      }
      ... on UserNotVerified{
        isVerified
        phoneNumber
      }
    }
  }
''';
const facebookLogin = '''
mutation facebookLogin(\$auth: LoginFacebookDto!) {
    facebookLogin(auth: \$auth) {
      ... on LoginResponseDto{
         accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
    userType
    userStatus
      }
      ... on UserNotVerified{
        isVerified
        phoneNumber
      }
    }
  }
''';
const appleLogin = '''
mutation appleLogin(\$auth: LoginAppleDto!) {
    appleLogin(auth: \$auth) {
      ... on LoginResponseDto{
         accessToken
    accessTokenExpirationDate
    refreshToken
    refreshTokenExpirationDate
    userType
    userStatus
      }
      ... on UserNotVerified{
        isVerified
        phoneNumber
      }
    }
  }
''';

const logoutQuery = '''mutation logout {
   logout
  }''';
const changePasswordQuery = '''
mutation resetMyPassword(\$resetMyPasswordDto: ResetMyPasswordDto!) {
    resetMyPassword(resetMyPasswordDto: \$resetMyPasswordDto) 
  }
''';
