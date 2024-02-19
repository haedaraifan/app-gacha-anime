class ImageModel {
  final int id;
  final String path;

  ImageModel({ required this.id, required this.path });

  ImageModel.fromMap({ required map })
    : id = map["id"],
      path = map["path"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "path": path
    };
  }
}