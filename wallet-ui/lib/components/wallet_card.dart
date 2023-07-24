import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isWhite;
  final int index;

  const WalletCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isWhite,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, index * -20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isWhite ? Colors.white : const Color(0xFF1F2123),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      color: isWhite ? const Color(0xFF1F2123) : Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color:
                              isWhite ? const Color(0xFF1F2123) : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color:
                              isWhite ? const Color(0xFF1F2123) : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-8, 12),
                  child: Icon(
                    icon,
                    color: isWhite ? const Color(0xFF1F2123) : Colors.white,
                    size: 84,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
