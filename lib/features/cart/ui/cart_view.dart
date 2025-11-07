import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/cart/data/repo/cart_repo.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/ui/widgets/cart_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Please login first')));
    }

    return BlocProvider(
      create: (context) => CartCubit(
        repo: CartRepo(firestore: FirebaseFirestore.instance),
        userId: currentUser.uid,
      )..listenToCart(),
      child: const CartBody(),
    );
    
  }
}
