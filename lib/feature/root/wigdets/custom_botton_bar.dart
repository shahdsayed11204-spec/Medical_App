import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            index: 0,
            icon: Icons.home,
          ),

          _buildItem(
            index: 1,
            icon: Icons.location_on_rounded,

          ),

          _buildItem(
            index: 2,
            icon: Icons.favorite_outline,

          ),

          _buildItem(
            index: 3,
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
  Widget _buildItem({
    required int index,
    required IconData icon,

  }) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xffF3F4F6)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? Color(0xff4B5563)
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}