import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:provider/provider.dart';

import '../screens/experience_list_page.dart';
import '../services/auth_state.dart';
import 'auth_guard.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == "My Experiences") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceListPage(),
              ),
            );
          } else if (item.name == "Add Experience") {
            final loggedIn = await ensureLoggedIn(context);

            if (!context.mounted || !loggedIn) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceFormPage(),
              ),
            );
          } else if (item.name == "Add Education") {
            final loggedIn = await ensureLoggedIn(context);

            if (!context.mounted || !loggedIn) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          } else if (item.name == "Login") {
            await ensureLoggedIn(context);
          } else if (item.name == "Logout") {
            final auth = context.read<AuthState>();

            if (auth.isLoggedIn) {
              try {
                await auth.logout();
              } catch (_) {
                // Token lokal tetap dibersihkan.
              }

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You are logged out.')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You are not logged in.')),
              );
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("You have pressed the ${item.name} button!"),
                ),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
