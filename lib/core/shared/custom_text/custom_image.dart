import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image, required this.rate});
  final String image, rate;
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
           image,
            height: 150,
            width: 118,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 10),
                  const SizedBox(width: 3),
                  Text(
                    rate,
                    style: const TextStyle(color: Colors.orange , fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
