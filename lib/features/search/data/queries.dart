const storeLocationQueries = """
 mutation updateUserLocation(\$updateUserLocation: UpdateUserLocationDto!) {
    updateUserLocation(updateUserLocation: \$updateUserLocation) 
  }
""";

const searchQueries = '''
query autocompleteSearch(\$pageOptionsDto: PageOptionsDto,\$searchInput:ServiceProviderSearchDto!){
  autocompleteSearch(pageOptionsDto:\$pageOptionsDto,
    searchInput:\$searchInput){
    ... on EventPaginatedResponseDto{
        response{
         id
         name
         
          }
      }
      ... on ProductPaginatedResponseDto{
        response{
          id
          name
          
        }
      }
    ...on ServicePaginatedResponseDto{
      response{
        id
        name
        
      }
    }
  }
} ''';

const searchOfServiceProviderForUser = '''

query searchOfServiceProviderForUser(
  \$pageOptionsDto: PageOptionsDto
  ,\$searchDto:SearchDto!){
  searchOfServiceProviderForUser(pageOptionsDto:\$pageOptionsDto,
    searchDto:\$searchDto){
      
       address{
        address
        country
        state
        __typename
        
      }
      company{
        description
        name
      }
      events{
        
        description
        startDate
        id
        createdAt
        name
        isActive
        images
        
      }
      generalInformation{
        distance
        latitude
        longitude
        fullName
        userChat{
          id
        }
        
      }
      isEventProgress
      id
      isAvailable
      photoUrl
      isFavorite
      userType
      
      
      products{
        
       description
        id
        images
        isActive
        name
        price
        
        
     
      
  
      
      
    }
      services{
        createdAt
         description
        id
        images
        isActive
        name
        price
      
      }
    }
  }
''';
const searchOfServiceProviderForGuest = '''

query searchOfServiceProviderForGuest(
  \$pageOptionsDto: PageOptionsDto
  ,\$searchDto:GuestSearchDto!){
  searchOfServiceProviderForGuest(pageOptionsDto:\$pageOptionsDto,
    searchDto:\$searchDto){
      
       address{
        address
        country
        state
        __typename
        
      }
      company{
        description
        name
      }
      events{
        
        description
        startDate
        id
        createdAt
        name
        isActive
        images
        
      }
      generalInformation{
        distance
        latitude
        longitude
        fullName
        userChat{
          id
        }
      }
      id
      userType
      isAvailable
      photoUrl
      isFavorite
      isEventProgress
      products{
        
       description
        id
        images
        isActive
        name
        price
        
        
     
      
  
      
      
    }
      services{
        createdAt
         description
        id
        images
        isActive
        name
        price
        
      }
    }
  }
''';
