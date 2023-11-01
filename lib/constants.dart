class ApiConstants {
  static String baseUrl = 'http://10.0.2.2:3000/api';
  static String authPath = '$baseUrl/auth';
  Map<String, String> headers = {'Content-type': 'application/json'};

  // static String flocksEndpoint = '/flocks';
  static String registerEndpoint = '/auth/register';
  static String loginEndpoint = '/auth/login';
  static String flocksEndpoint = '/flocks/paging?take=10&skip=0';
  static String locationsEndpoint = '/locations/paging?take=10&skip=0';
  static String userByIdEndpoint = '/users/';
  static String locationByIdEndpoint = '/location/';
  static String allVibesEndpoint = '/vibes';
}
