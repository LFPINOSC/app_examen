import 'package:app_examen/Provider/provider_login.dart';
import 'package:app_examen/Screens/genero_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<ProviderLogin>().logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido al Dashboard', style: TextStyle(fontSize: 24)),
            Card(
              elevation: 4,
              shape: context.watch<ProviderLogin>().token != null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  : null,
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Generos'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeneroScreen()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ProviderLogin>().logout();
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
