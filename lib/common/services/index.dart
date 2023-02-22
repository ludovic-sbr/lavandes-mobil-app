Map<String, String> getHeaders() {
  var token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzb2JyZXJvLmx1ZG92aWNAZ21haWwuY29tIiwiaWF0IjoxNjc2OTkzMjEyLCJleHAiOjE2NzcwNzk2MTIsImlzcyI6ImdhcmRvbnMifQ.CjTT9OoEKCuRSGhnuB4ey2i9LxnZTkBJVcEQNjrM84RaFUVScZliYB-crlKF0qf_p13z5jxk5E1EsPcV7yPn4Q';

  return {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json; charset=utf-8',
  };
}

String apiUrl = 'https://api.camping-lavandes.com/api';
