import 'package:flutter/material.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class WelcomePage extends StatelessWidget {
  final String title = "Lotteriespiel-App";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: lotteryAppBar(title),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Willkommen, du bist willkommen auf der Willkommensseite unserer tollen Lotterie-App!",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await LocalStorageService.setIsFirstUse(false);
                    Navigator.popAndPushNamed(context, "/overview");
                  },
                  child: Text("Weiter")),
            ],
          ),
        ),
      ),
    );
  }
}
