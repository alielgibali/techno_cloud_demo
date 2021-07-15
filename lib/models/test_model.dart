
class TestModel {
  String docId;
  String title;
  String description;
  String imageUrl;
  bool isSelected;

  TestModel(
      {this.docId,
       this.title,
       this.description,
       this.imageUrl, 
       this.isSelected});

  TestModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['image_url'] ?? "";
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docId'] = this.docId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['isSelected']= this.isSelected;
    return data;
  }
}
