Map<String, String> getHeaders() {
  var token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzb2JyZXJvLmx1ZG92aWNAZ21haWwuY29tIiwiaWF0IjoxNjc1NzYyMjA2LCJleHAiOjE2NzU4NDg2MDYsImlzcyI6ImdhcmRvbnMifQ.ttIL-Sbqejwkr0FHNFlHDk1UIV9V9QfmhbA95vH6NxVAoua_M0uf-B90LXQurn9L9psEU8q6gKQODYbn2k5DzQ'; // on récupère le token dans le storage

  return {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
}
