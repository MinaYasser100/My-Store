import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/home/data/repo/like_product_repo.dart';

part 'like_product_state.dart';

class LikeProductCubit extends Cubit<LikeProductState> {
  LikeProductCubit(this._likeRepo) : super(LikeProductInitial());

  final LikeProductRepo _likeRepo;

  Future<void> toggleLikeStatus(String productId, bool isCurrentlyLiked) async {
    try {
      if (isCurrentlyLiked) {
        final result = await _likeRepo.unlikeProduct(productId);
        result.fold(
          (error) => emit(LikeProductFailure(error)),
          (_) => emit(LikeProductUnliked(productId)),
        );
      } else {
        final result = await _likeRepo.likeProduct(productId);
        result.fold(
          (error) => emit(LikeProductFailure(error)),
          (_) => emit(LikeProductLiked(productId)),
        );
      }
    } catch (e) {
      emit(LikeProductFailure('An unexpected error occurred'));
    }
  }
}
