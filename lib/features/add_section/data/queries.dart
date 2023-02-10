const createEventQueries = '''
mutation createEvent(\$createEventDto: CreateEventDto!
){
  createEvent(createEventDto:\$createEventDto){
    id
    name
    description
    images
    videos
    startDate
    endDate
  }
}
''';
const getEventQueries = '''
query getAllEventsByServiceProvider(
\$pageOptionsDto: PageOptionsDto
){
  getAllEventsByServiceProvider(pageOptionsDto:\$pageOptionsDto){
    response{
      id
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
const updateEventQueries = '''
mutation updateEvent(
\$eventId: String!
\$updateEventDto: UpdateEventDto!
){
  updateEvent(eventId:\$eventId,updateEventDto:\$updateEventDto){
    id
    name
    description
    images
    videos
    startDate
    endDate
  }
}
''';

const deleteEventQueries = '''
mutation deleteEvent(
\$eventId: String!
){
  deleteEvent(eventId:\$eventId)
}
''';

const addMediaQueries = '''
mutation addMedia(
\$createGalleryDto: CreateGalleryDto!
){
  addMedia(createGalleryDto:\$createGalleryDto){
    media
    type
  }
}
''';

const getMediaQueries = '''
query getMyGallery(
\$pageOptionsDto: PageOptionsDto
){
  getMyGallery(pageOptionsDto:\$pageOptionsDto){
    response{
      media
      type
      id
    }
  }
}
''';

const deleteMediaQueries = '''
mutation deleteMedia(
\$id: String!
){
  deleteMedia(id:\$id){
    media
    type
    id
  }
}
''';

const deleteArticle = '''
mutation deleteArticle(\$id:String!){
  deleteArticle(id:\$id){
    createdAt
    text
  }
}
''';

const getArticles = '''
query getMyArticles(
\$pageOptionsDto: PageOptionsDto

){
  getMyArticles(pageOptionsDto:\$pageOptionsDto){
    response{
      createdAt
    id
    title
    text
    images
    videos
    }
  }
}
''';

const createArticle = '''
mutation createArticle(\$createArticleDto:CreateArticleDto!){
  createArticle(createArticleDto:\$createArticleDto){
    id
    images
     createdAt
    text
    title
    videos
    influencer{
      id
    }
    serviceProvider{
      articles{
        id
      }
      generalInformation{
        email
       }
    }
  }
  }
''';
const editArticle = '''
mutation updateArticle(\$id:String!,\$updateArticleDto:UpdateArticleDto!){
  updateArticle(id:\$id,updateArticleDto:\$updateArticleDto){
    createdAt
    id
    images
    influencer{
     id
      
    }
    serviceProvider{
      articles{
        id
      }
    }
    title
    text
    videos
  }
}
''';

const searchOfServiceProviderByName = '''
query searchOfServiceProviderByName (\$name: String!){
  searchOfServiceProviderByName(name: \$name){
    id
    generalInformation {
      firstName
    }
  }
}
''';

const searchOfInfluencerByName = '''
query searchOfInfluencerByName (\$name: String!){
  searchOfInfluencerByName(name: \$name){
    id
    generalInformation {
      firstName
    }
  }
}

''';
