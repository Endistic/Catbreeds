class CatModel {
  String description;
  String id;
  CatImage image;

  String name;

  Weight weight;

  CatModel({
    this.description,
    this.id,
    this.image,
    this.name,
    this.weight,
  });

  CatModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];

    id = json['id'];
    image = json['image'] != null ? new CatImage.fromJson(json['image']) : null;

    name = json['name'];

    weight =
        json['weight'] != null ? new Weight.fromJson(json['weight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = this.description;

    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }

    data['name'] = this.name;

    if (this.weight != null) {
      data['weight'] = this.weight.toJson();
    }

    return data;
  }
}

class CatImage {
  int height;
  String id;
  String url;
  int width;

  CatImage({this.height, this.id, this.url, this.width});

  CatImage.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    id = json['id'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['id'] = this.id;

    data['url'] = this.url;

    data['width'] = this.width;
    return data;
  }
}

class Weight {
  String imperial;
  String metric;

  Weight({this.imperial, this.metric});

  Weight.fromJson(Map<String, dynamic> json) {
    imperial = json['imperial'];
    metric = json['metric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imperial'] = this.imperial;
    data['metric'] = this.metric;
    return data;
  }
}
