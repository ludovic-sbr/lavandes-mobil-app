Map<String, String> getHeaders() {
  var token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzb2JyZXJvLmx1ZG92aWNAZ21haWwuY29tIiwiaWF0IjoxNjc3MDc1NTQxLCJleHAiOjE2NzcxNjE5NDEsImlzcyI6ImdhcmRvbnMifQ.St5-HmF32peVmr2WHiIw0ysxTlfabjvQOhGEaCfUfyJY7PbjzmzWDjgDrOS17PL6uUEi6KuCuLIYkyuR1X22jg';

  return {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json; charset=utf-8',
  };
}

String apiUrl = 'https://api.camping-lavandes.com/api';
