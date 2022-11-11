import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshIndicator({super.key, required this.child, required this.onRefresh});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: theme.primaryColor,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(child: child),
        ],
      ),
    );
  }
}
