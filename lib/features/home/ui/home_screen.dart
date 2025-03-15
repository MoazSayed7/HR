import 'package:flutter/material.dart';

import '../../../core/theme/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: TextStyles.font12DarkBlueRegular),
      ),
    );
  }
}
