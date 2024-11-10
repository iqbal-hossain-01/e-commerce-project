import 'package:e_commerce_app/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardModel dashboardModel;

  const DashboardItemView({super.key, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(dashboardModel.routeName),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                dashboardModel.iconData,
                color: Colors.deepPurple,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dashboardModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
