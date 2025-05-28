class Utils {
  static const String baseUrl = "https://phictly-backend.vercel.app/api/v1";
  static const String secondBaseUrl = "https://cpneena-backend.vercel.app/api/v1";
  static const String singup = '/users/create';
  static const String login = "/auth/login";
  static const String createClub = "/club/create";
  static const String profile = "/profile/my-profile";
  static const String trendingOrRecent = "/club/trending-or-recent";
  static String genre(String genreType) => "/genre?type=$genreType&sortOrder=desc&page=1&limit=10";
  static String genreWithOutType = "/genre?sortOrder=desc&page=1&limit=10";
  static const String bookGenre = "/genre?type=BOOK&sortOrder=desc&page=1&limit=10";
  static const String genreTv = "/genre?type=MOVIE&sortOrder=desc&page=1&limit=10";
  static String idUrl(String id)=> "/genre/$id?page=1&limit=5&type=MOVIE";
  static String createdClub(String id)=> "/club/$id";
  static String bookSearchUrl(String type, String queryValue)=> "/club/search-book-or-movie?type=$type&searchQuery=$queryValue";
  static String getClubId = "/club/generate-clubId";
  static String createPost = "/post/create";
  static String createReply = "/post/comment/create";
  static String updateProfile = "/auth/profile";
  static String statusUpdate(String id) => "/post/post-status-update/$id";
  static String clubStatusUpdate = "/club/join-status-update";
  static String privateClubJoinRequest(String id) => "/club/joining-private/$id";
  static String searchAllClubs(String queryValue) => "/club?page=1&limit=35&searchQuery=$queryValue";
}