const deleteAccountQueries = '''
mutation deleteMyAccount(
\$deleteMyAccountDto: DeleteMyAccountDto!
){
  deleteMyAccount(deleteMyAccountDto:\$deleteMyAccountDto)
}
''';
//General Information For Service Provider
const getServiceProviderGeneralInfoByIDQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
  isAvailable
   photoUrl
    isFavorite
    userType
    isEventProgress
    generalInformation{
      fullName
      latitude
      longitude
      distance
      userChat{
          id
       }
      
      
    },
    activities{
      id
      name
    },
    company{
      job
      name
      description
    },
  }
}
''';
const getServiceProviderGeneralInfoByIDQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
  isAvailable
   photoUrl
    userType
    isEventProgress
    generalInformation{
      fullName
      latitude
      longitude
      distance
      userChat{
          id
       }
      
      
    },
    activities{
      id
      name
    },
    company{
      job
      name
      description
    },
  }
}
''';

//Get All Service For Service Provider
const getServiceByServiceProvideIdQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
    services{
      id
      name
      description
      images
      videos
      price
    }
}
}
''';
const getServiceByServiceProvideIdQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
   services{
    id
    name
    description
    images
    videos
    price
  }
  }
}
''';
//Get All Products For Service Provider
const getProductsByServiceProvideIdQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
    products{
      id
      name
      description
      images
      videos
      price
    }
}
}
''';
const getProductsByServiceProvideIdQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
   products{
    id
    name
    description
    images
    videos
    price
  }
  }
}
''';
//Get All Event For Service Provider
const getEventByServiceProvideIdQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
    events{
      id
      name
      description
      images
      videos
      startDate
      endDate
    }
}
}
''';

const getEventByServiceProvideIdQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
    events{
      images
      videos
      name
      description
       startDate
      endDate
    }
  }
}
''';
const getArticlByServiceProvideIdQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
    articles{
      id
      title
      text
      images
      videos
      createdAt
    }
  }
}
''';
const getArticlByServiceProvideIdQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
    articles{
      id
      title
      text
      images
      videos
      createdAt
    }
  }
}
''';

const toggleFavoriteQueries = '''mutation toggleFavorite(\$createFavoriteDto: CreateFavoriteDto!) {
    toggleFavorite(createFavoriteDto:\$createFavoriteDto) {
    type
  }
}''';
const toggleIsAvialable = '''
mutation toggleIsAvialable{
  toggleIsAvialable{
    isAvailable
    
  }
  }
''';
const getMyFavoriteQuery = '''query getMyFavorite(\$type: String!) {
    getMyFavorite(type:\$type){
    id,
    influencer{
      id
      generalInformation{
        fullName
        email
        firstName
        lastName
        phoneNumber
      }
      photoUrl
      userType
      userStatus
      facebookUrl
      facebookFollowers
      twitterUrl
      twitterFollowers
      tiktokUrl
      tiktokFollowers
      instagramUrl
      instagramFollowers
      youtubeUrl
      youtubeFollowers
      snapchatUrl
      snapchatFollowers
    },
    serviceProvider{
      id
      generalInformation{
        fullName
        latitude
        longitude
      }
      company{
        description
        job
        name
      }
      isFavorite
      photoUrl
      userType
      userStatus
      isAvailable
    },
    
  }
}''';

const getInfluncerGeneralInfomationByIDQueriesUser = '''
query influencerForUser(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForUser(getInfluencerProfileDto:\$getInfluencerProfileDto){
   photoUrl
    userType
    generalInformation{
      fullName
      latitude
      longitude
      
          },
    categories{
      id
      name
    },
    facebookUrl
    facebookFollowers
    youtubeUrl
    youtubeFollowers
    tiktokUrl
    tiktokFollowers
    instagramUrl
    instagramFollowers
    twitterUrl
    twitterFollowers
  }
}
''';
const getInfluncerGeneralInfomationByIDQueriesGuest = '''
query influencerForGuest(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForGuest(getInfluencerProfileDto:\$getInfluencerProfileDto){
   photoUrl
    userType
    generalInformation{
      fullName
      latitude
      longitude
      
          },
    categories{
      id
      name
    },
    facebookUrl
    facebookFollowers
    youtubeUrl
    youtubeFollowers
    tiktokUrl
    tiktokFollowers
    instagramUrl
    instagramFollowers
    twitterUrl
    twitterFollowers
  }
}
''';
const getArticlByInfluncerIdQueriesUser = '''
query influencerForUser(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForUser(getInfluencerProfileDto:\$getInfluencerProfileDto){
   articles{
    id
    title
    text
    videos
    images
    createdAt
  }
  }
}
''';
const getArticlByInfluncerIdQueriesGuest = '''
query influencerForGuest(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForGuest(getInfluencerProfileDto:\$getInfluencerProfileDto){
 articles{
  id
    title
    text
    videos
    images
    createdAt
  }
  }
}
''';

const getgalleryByInfluncerIdQueriesUser = '''
query influencerForUser(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForUser(getInfluencerProfileDto:\$getInfluencerProfileDto){
   gallery{
 media
    type
    id
  }
  }
}
''';
const getgalleryByInfluncerIdQueriesGuest = '''
query influencerForGuest(
\$getInfluencerProfileDto: GetInfluencerProfileDto!
){
  influencerForGuest(getInfluencerProfileDto:\$getInfluencerProfileDto){
   gallery{
 media
    type
    id
  }
  }
}
''';
const getgalleryBySPIdQueriesUser = '''
query serviceProviderForUser(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForUser(getProfileDto:\$getProfileDto){
      gallery{
 media
    type
    id
  }
  }
}
''';
const getgalleryBySPIdQueriesGuest = '''
query serviceProviderForGuest(
\$getProfileDto: GetProfileDto!
){
  serviceProviderForGuest(getProfileDto:\$getProfileDto){
      gallery{
 media
    type
    id
  }
  }
}
''';
