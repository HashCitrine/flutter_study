import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String title;
  final String amount;
  final String currency;
  final bool isInverted;
  final IconData icon;
  final int order;
  late double dy;
  Color textColor = Colors.black;
  Color bgColor = Colors.white;

  CurrencyCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.currency,
      required this.isInverted,
      required this.icon,
      required this.order}) {
    if (!isInverted) {
      textColor = Colors.white;
      bgColor = Colors.black;
    }

    dy = (order - 1) * -20;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, dy),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
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
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        currency,
                        style: TextStyle(
                          color: textColor.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: textColor,
                    size: 88,
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
