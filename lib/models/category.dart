class Category {
  String id;
  String nom;
  String description;
  String mobIcon;
  String webIcon;
  String image;
  Category(
      {this.id,
      this.nom,
      this.description,
      this.mobIcon,
      this.webIcon,
      this.image});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['_id'],
        nom: json['nom'],
        mobIcon: json['mobIcon'],
        webIcon: json['webIcon'],
        image: json['image']);
  }
}
