import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng học tiếng Anh"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chọn chế độ học",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.95,
                children: [
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.menu_book,
                    label: "Từ vựng",
                    onTap: () => Navigator.pushNamed(context, '/vocabulary'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.rule,
                    label: "Ngữ pháp",
                    onTap: () => Navigator.pushNamed(context, '/grammar'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.quiz,
                    label: "Quiz",
                    onTap: () => Navigator.pushNamed(context, '/quiz'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.favorite,
                    label: "Yêu thích",
                    onTap: () => Navigator.pushNamed(context, '/favorites'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMenuCard(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.85),
              Theme.of(context).primaryColor.withOpacity(0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
