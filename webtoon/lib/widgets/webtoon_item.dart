import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';

class WebtoonItem extends StatelessWidget {
  final String id, title, thumb;

  const WebtoonItem({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DeatilScreen(id: id, title: title, thumb: thumb),
          ),
        );
      },
      child: Hero(
        tag: id,
        child: Column(
          children: [
            Container(
              width: 256,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(1, 0),
                    color: Colors.black.withOpacity(0.15),
                  )
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(thumb),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
