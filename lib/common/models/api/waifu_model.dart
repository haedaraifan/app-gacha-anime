import 'dart:convert';

WaifuRes waifuResFromMap(String str) => WaifuRes.fromMap(json.decode(str));

String waifuResToMap(WaifuRes data) => json.encode(data.toMap());

class WaifuRes {
    final List<ImageResponseModel>? images;

    WaifuRes({
        this.images,
    });

    factory WaifuRes.fromMap(Map<String, dynamic> json) => WaifuRes(
        images: List<ImageResponseModel>.from(json["images"].map((x) => ImageResponseModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
    };
}

class ImageResponseModel {
    final String signature;
    final String extension;
    final int imageId;
    final int favorites;
    final String dominantColor;
    final String source;
    final dynamic artist;
    final DateTime uploadedAt;
    final dynamic likedAt;
    final bool isNsfw;
    final int width;
    final int height;
    final int byteSize;
    final String url;
    final String previewUrl;
    final List<Tag> tags;

    ImageResponseModel({
        required this.signature,
        required this.extension,
        required this.imageId,
        required this.favorites,
        required this.dominantColor,
        required this.source,
        required this.artist,
        required this.uploadedAt,
        required this.likedAt,
        required this.isNsfw,
        required this.width,
        required this.height,
        required this.byteSize,
        required this.url,
        required this.previewUrl,
        required this.tags,
    });

    factory ImageResponseModel.fromMap(Map<String, dynamic> json) => ImageResponseModel(
        signature: json["signature"],
        extension: json["extension"],
        imageId: json["image_id"],
        favorites: json["favorites"],
        dominantColor: json["dominant_color"],
        source: json["source"],
        artist: json["artist"],
        uploadedAt: DateTime.parse(json["uploaded_at"]),
        likedAt: json["liked_at"],
        isNsfw: json["is_nsfw"],
        width: json["width"],
        height: json["height"],
        byteSize: json["byte_size"],
        url: json["url"],
        previewUrl: json["preview_url"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "signature": signature,
        "extension": extension,
        "image_id": imageId,
        "favorites": favorites,
        "dominant_color": dominantColor,
        "source": source,
        "artist": artist,
        "uploaded_at": uploadedAt.toIso8601String(),
        "liked_at": likedAt,
        "is_nsfw": isNsfw,
        "width": width,
        "height": height,
        "byte_size": byteSize,
        "url": url,
        "preview_url": previewUrl,
        "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
    };
}

class Tag {
    final int tagId;
    final String name;
    final String description;
    final bool isNsfw;

    Tag({
        required this.tagId,
        required this.name,
        required this.description,
        required this.isNsfw,
    });

    factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        tagId: json["tag_id"],
        name: json["name"],
        description: json["description"],
        isNsfw: json["is_nsfw"],
    );

    Map<String, dynamic> toMap() => {
        "tag_id": tagId,
        "name": name,
        "description": description,
        "is_nsfw": isNsfw,
    };
}
