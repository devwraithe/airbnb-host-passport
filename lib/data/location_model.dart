class Listing {
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
  final List infoItems;

  const Listing({
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
    required this.infoItems,
  });
}
