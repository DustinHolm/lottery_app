import 'package:flutter/material.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Willkommen!"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
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
