import 'package:flutter/material.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/welcome_page.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: LocalStorageService.getIsFirstUse(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return WelcomePage();
          } else if (snapshot.hasData && snapshot.data == false) {
            return OverviewPage();
          } else {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
