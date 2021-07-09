import 'package:flutter/material.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/welcome_page.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: LocalStorageService.getIsFirstUse(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return const WelcomePage();
          } else if (snapshot.hasData && snapshot.data == false) {
            return const OverviewPage();
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
