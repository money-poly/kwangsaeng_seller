class Origin {
  String ingredient;
  String country;

  Origin({
    required this.ingredient,
    required this.country,
  });

  factory Origin.fromJson(Map<dynamic, dynamic> json) => Origin(
        ingredient: json['ingredient'],
        country: json['origin'],
      );
}
