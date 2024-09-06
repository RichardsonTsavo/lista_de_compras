// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum ListType {
  LIST,
  GRID,
  LISTNOTREBUILD,
}

class AnimatedListWidget extends StatelessWidget {
  final ScrollController? controller;
  final ListType listType;
  final List<Widget> childs;
  final int crossAxisCount;
  final bool shrinkWrap;
  final EdgeInsets padding;
  const AnimatedListWidget(
      {Key? key,
      this.controller,
      required this.listType,
      required this.childs,
      this.shrinkWrap = false,
      this.padding = EdgeInsets.zero,
      this.crossAxisCount = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listType == ListType.LISTNOTREBUILD) {
      return AnimationLimiter(
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                ...List.generate(
                  childs.length,
                  (index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: childs[index],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    if (listType == ListType.LIST) {
      return AnimationLimiter(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          controller: controller,
          padding: padding,
          primary: shrinkWrap ? false : null,
          shrinkWrap: shrinkWrap,
          itemCount: childs.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: ScaleAnimation(
              child: childs[index],
            ),
          ),
        ),
      );
    }
    return AnimationLimiter(
      child: GridView.builder(
        padding: padding,
        shrinkWrap: shrinkWrap,
        primary: shrinkWrap ? false : null,
        controller: controller,
        itemCount: childs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount),
        itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: 3,
          child: ScaleAnimation(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: childs[index],
            ),
          ),
        ),
      ),
    );
  }
}
