import 'dart:math';

import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:flutter/material.dart';

import 'book_back.dart';
import 'book_cover_back.dart';
import 'book_cover_front.dart';

class BookFlip extends StatefulWidget {
  const BookFlip(
    this.listing, {
    super.key,
    this.initialFlipProgress = 0,
    this.animationController,
  });

  final Location listing;
  final double initialFlipProgress;
  final Animation<double>? animationController;

  @override
  State<BookFlip> createState() => _BookFlipState();
}

class _BookFlipState extends State<BookFlip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      value: widget.initialFlipProgress,
    );

    _animation = widget.animationController ??
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        );

    _flipAnimation = Tween<double>(begin: 1, end: 0).animate(_animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return FractionalTranslation(
            translation: Offset(-0.5 * _flipAnimation.value, 0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 220),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: BookBack(widget.listing),
                  ),
                  Expanded(
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015)
                        ..rotateY(-pi * _flipAnimation.value),
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: [
                          _flipAnimation.value <= 0.5
                              ? Positioned.fill(
                                  child: BookCoverBack(
                                    listing: widget.listing,
                                  ),
                                )
                              : Positioned.fill(
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.0015)
                                      ..rotateY(-pi),
                                    alignment: Alignment.center,
                                    child: BookCoverFront(widget.listing),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
