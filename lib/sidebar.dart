import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Lotteriespiel-App",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(color: Colors.white),
                  ))),
          ListTile(
              title: const Text('Übersicht'),
              onTap: () => Navigator.pushNamed(context, '/overview')),
          ListTile(
              title: const Text('Offene Gebote'),
              onTap: () => Navigator.pushNamed(context, '/bidder')),
          ListTile(
              title: const Text('Eigene Angebote'),
              onTap: () => Navigator.pushNamed(context, '/seller')),
          ListTile(
              title: const Text('Angebot erstellen'),
              onTap: () => Navigator.pushNamed(context, '/create')),
          ListTile(
              title: const Text('Tickets kaufen'),
              onTap: () => Navigator.pushNamed(context, '/tickets')),
        ],
      ),
    );
  }
}
