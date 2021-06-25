import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text('Übersicht'),
              onTap: () => Navigator.pushNamed(context, '/overview')),
          ListTile(
            title: Text('Offene Gebote'),
            onTap: () => Navigator.pushNamed(
              context,
              '/bidder'
            )
          ),
          ListTile(
            title: Text('Eigene Angebote'),
            onTap: () => Navigator.pushNamed(
              context,
              '/seller'
            )
          ),
          ListTile(
              title: Text('Angebot erstellen'),
              onTap: () => Navigator.pushNamed(
                  context,
                  '/create'
              )
          ),
          ListTile(
              title: Text('Tickets kaufen'),
              onTap: () => Navigator.pushNamed(context, '/tickets')),
        ],
      ),

    );
  }
}