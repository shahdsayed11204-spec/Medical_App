import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/feature/root/cubit/root_state.dart';

import '../../appointment/presentation/view/appointment_view.dart';
import '../../auth/presention/view/profile_view.dart';
import '../../home/presentation/view/home_view.dart';
import '../../nearby/presentation/view/nearby_view.dart';


class RootCubit extends Cubit<RootStates> {
  RootCubit() : super(RootInitialStates());

  int currentIndex = 0;

  final List<Widget> screen = [
    HomeView(),
    NearbyView(),
    AppointmentView(),
    ProfileView(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(RootBottomNavSheetStates());
  }
}