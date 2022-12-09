class Book {
  final String id;
  final String image;
  final String title;
  final String author;
  final double price;
  bool? isWishlist;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.price,
      this.isWishlist});
}
