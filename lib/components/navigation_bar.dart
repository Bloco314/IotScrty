import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Jose123'),
            accountEmail: Text('Migliorin@mori.manuel.com'),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Braz%C3%A3o_UEA.jpg/300px-Braz%C3%A3o_UEA.jpg",
                width: 100,
                height: 100,
              ),
            )),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://imgs.search.brave.com/ybYeaAEnZLyWPPSCbokEc8qen6-wUyLCWfgUJuUNktI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9mYXN0/bHkuNHNxaS5uZXQv/aW1nL2dlbmVyYWwv/NjAweDYwMC9USEpS/U0xKSVdXSEtYTFVB/QUY0REgyQk9YWEVJ/TEZBV1ZLMTExWDJI/TFRaVTFIRTEuanBn"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('favorites'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('abc'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('another thing'),
            onTap: () => null,
          ),
          Divider(),
        ],
      ),
    );
  }
}
