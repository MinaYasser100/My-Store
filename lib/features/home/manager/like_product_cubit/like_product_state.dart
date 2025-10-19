part of 'like_product_cubit.dart';

@immutable
sealed class LikeProductState {}

final class LikeProductInitial extends LikeProductState {}

final class LikeProductLiked extends LikeProductState {
  final String productId;
  LikeProductLiked(this.productId);
}

final class LikeProductUnliked extends LikeProductState {
  final String productId;
  LikeProductUnliked(this.productId);
}

final class LikeProductFailure extends LikeProductState {
  final String error;
  LikeProductFailure(this.error);
}
