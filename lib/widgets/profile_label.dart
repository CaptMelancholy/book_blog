import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.text,
    required this.currentIndex,
  });

  final int currentIndex;
  final String text;

  IconData getCurrentIcon() {
    switch(currentIndex) {
      case 0: return Icons.mail;
      case 1: return Icons.document_scanner_outlined;
      case 2: return Icons.account_circle_outlined;
      case 3: return Icons.description;
      case 4: return Icons.numbers;
      case 5: return Icons.book;
      case 6: return Icons.man;
      case 7: return Icons.bookmark;
      default: return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                getCurrentIcon(),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
      ),
    );
  }
}