Map<String, String> getHeaders() {
  var token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzb2JyZXJvLmx1ZG92aWNAZ21haWwuY29tIiwiaWF0IjoxNjc2NjQ0Mzg3LCJleHAiOjE2NzY3MzA3ODcsImlzcyI6ImdhcmRvbnMifQ.20-_x-hn1Fz-_uZcFxOWCQvlldWGNBanycn6Dl_oPxbmsi4uoMacTUGiOwrGhTeXn2QuB8PMJ_UVbENO_VQZow'; // on récupère le token dans le storage

  return {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json; charset=utf-8',
  };
}
