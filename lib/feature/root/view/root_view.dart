import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_colors.dart';
import '../cubit/root_cubit.dart';
import '../cubit/root_state.dart';
import '../wigdets/custom_botton_bar.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocBuilder<RootCubit, RootStates>(
        builder: (context, state) {
          final cubit = context.read<RootCubit>();
          return Material(
            color: Colors.white,
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Scaffold(
            backgroundColor: Colors.white,
              body: IndexedStack(
                index: cubit.currentIndex,
                children: cubit.screen,
              ),

              bottomNavigationBar: CustomBottomBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}