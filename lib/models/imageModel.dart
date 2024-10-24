class Photomodel {
  String? url;
  SrcModel? src;
  Photomodel({
    this.url,
    this.src,
  });
  factory Photomodel.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Photomodel(
      url: parsedJson['url'],
      src: SrcModel.fromJsonMap(parsedJson['src']),
    );
  }
}

class SrcModel {
  String? portrait;
  String? large;
  String? landscape;
  String? medium;
  SrcModel({
    this.portrait,
    this.large,
    this.landscape,
    this.medium,
  });
  factory SrcModel.fromJsonMap(Map<String, dynamic> parsedJson) {
    return SrcModel(
        portrait: parsedJson['portrait'],
        large: parsedJson['large'],
        landscape: parsedJson['landscape'],
        medium: parsedJson['medium']);
  }
}
