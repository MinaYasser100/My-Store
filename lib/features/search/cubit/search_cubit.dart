import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final snapshot = await _firestore.collection('Products').get();

      final allResults = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();

      final filterResults = allResults
          .where(
            (product) =>
                product.title?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();

      emit(SearchLoaded(filterResults));
    } catch (e) {
      emit(SearchError('Search failed: ${e.toString()}'));
    }
  }
}
