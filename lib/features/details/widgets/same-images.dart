
import 'package:flutter/material.dart';

Widget BuildYouCanAlsoLikeSection(List<String> images) {

    return Column(
      children: images.map((imageUrl) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }