class ShopCommentModel {
  ShopCommentModel({
    required this.comment,
    required this.commentDate,
    required this.userName,
    required this.userSurname,
    required this.rating,
    required this.boxStatus,
  });

  final String? comment;
  final String? commentDate;
  final String? userName;
  final String? userSurname;
  final int? rating;
  final String? boxStatus;

}
