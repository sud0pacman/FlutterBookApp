class BookData {
  final String id;
  final String authorName;
  final String bookName;
  final String category;
  final String audioUrl;
  final String pdfUrl;
  final String imgUrl;

  BookData({
    required this.id,
    required this.authorName,
    required this.bookName,
    required this.category,
    required this.audioUrl,
    required this.pdfUrl,
    required this.imgUrl,
  });

  factory BookData.fromMap(String id, Map<String, dynamic> data) {
    return BookData(
      id: id,
      authorName: data['author_name'] ?? '',
      bookName: data['book_name'] ?? '',
      category: data['category'] ?? '',
      audioUrl: data['audio_url'] ?? '',
      pdfUrl: data['pdf_url'] ?? '',
      imgUrl: data['img_url'] ?? '',
    );
  }
}