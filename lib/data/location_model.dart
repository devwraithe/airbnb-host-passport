class Location {
  final int id;
  final String city,
      country,
      image,
      hostName,
      hostImage,
      timeFrom,
      timeTo,
      amount,
      rating,
      reviews,
      yearsHosting;

  const Location({
    required this.id,
    required this.city,
    required this.country,
    required this.image,
    required this.hostName,
    required this.hostImage,
    required this.timeFrom,
    required this.timeTo,
    required this.amount,
    required this.rating,
    required this.reviews,
    required this.yearsHosting,
  });
}
