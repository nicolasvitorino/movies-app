import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MovieNavigationMenu extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  const MovieNavigationMenu({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    void onIconPressed(int index) {
      if (index == currentIndex) return;

      onIndexChanged(index);

      if (index == 0) {
        context.go('/');
      } else {
        context.go('/search');
      }
    }

    return Container(
      padding: const EdgeInsets.all(4),
      height: 58,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: currentIndex == 0
                  ? const Color(0xFF2B64DF)
                  : Colors.transparent,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
              onPressed: () => onIconPressed(0),
            ),
          ),
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: currentIndex == 1
                  ? const Color(0xFF2B64DF)
                  : Colors.transparent,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              onPressed: () => onIconPressed(1),
            ),
          ),
        ],
      ),
    );
  }
}
