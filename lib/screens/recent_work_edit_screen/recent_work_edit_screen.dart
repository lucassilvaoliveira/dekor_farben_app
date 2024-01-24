import 'package:dekor_farben_app/blocs/recent_work/recent_work_bloc.dart';
import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/screens/recent_work_edit_screen/view/recent_work_edit_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentWorkEditScreen extends StatelessWidget {
  final RecentWork recentWork;

  const RecentWorkEditScreen({super.key, required this.recentWork});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecentWorkBloc>(
      create: (context) => RecentWorkBloc(),
      child: Scaffold(
        body: RecentWorkEditBody(recentWork: recentWork),
      ),
    );
  }
}
