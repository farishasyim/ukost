import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    super.key,
    this.height = 304,
    this.images = const [],
  });
  final double height;
  final List<String> images;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  ValueNotifier<int> index = ValueNotifier(0);
  PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: screenWidth(context),
      child: Stack(
        children: [
          StreamBuilder<int>(
              stream: Stream.periodic(
                const Duration(
                  seconds: 10,
                ),
                (e) {
                  if (index.value < (widget.images.length - 1)) {
                    controller.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  } else {
                    controller.animateToPage(
                      0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  }

                  return e;
                },
              ),
              builder: (context, snapshot) {
                return PageView(
                  onPageChanged: (e) {
                    index.value = e;
                  },
                  controller: controller,
                  children: [
                    for (var row in widget.images)
                      Image.asset(
                        row,
                        fit: BoxFit.cover,
                      ),
                  ],
                );
              }),
          ValueListenableBuilder(
            valueListenable: index,
            builder: (context, value, _) {
              return Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < widget.images.length; i++)
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.value == i
                              ? ColorAsset.violet
                              : ColorAsset.black,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
