class File {
  final int id;
  final String name;
  final String path;
  final String publicUrl;

  File(
      {required this.id,
      required this.name,
      required this.path,
      required this.publicUrl});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      publicUrl: json['publicUrl'] as String,
    );
  }
}
