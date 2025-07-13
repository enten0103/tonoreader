import 'package:flutter/material.dart';
import 'package:voidlord/components/ios_showcase/ios_expend_card_raw.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class ExpendCardView extends StatefulWidget {
  const ExpendCardView({super.key, required this.dates});

  final List<IOSShowCaseDate> dates;

  @override
  State<StatefulWidget> createState() => _ExpendCardViewState();
}

class _ExpendCardViewState extends State<ExpendCardView> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  double _currentScale = 1.0;
  int? _currentPageIndex;
  bool _enableHorizontalScroll = true;
  final int _initialPage = 100000;

  final double topGap = 60;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_initialPage);
      _currentPageIndex = _initialPage;
    });
  }

  // 计算缩放值的方法
  double _calculateScale(double scrollOffset) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxScale = screenWidth / (screenWidth * 0.9 - 10);
    if (scrollOffset >= topGap) return maxScale;
    return 1.0 + (scrollOffset / topGap) * (maxScale - 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        alignment: Alignment.topCenter,
        scale: _currentScale,
        child: Stack(children: [
          Positioned.fill(
              child: Container(
            color: Colors.black.withAlpha(140),
          )),
          PageView.builder(
            controller: _pageController,
            physics: _enableHorizontalScroll
                ? const PageScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: null,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
                _enableHorizontalScroll = true;
              });
            },
            itemBuilder: (context, index) {
              final actualIndex = index % widget.dates.length;
              final isCurrentPage = index == _currentPageIndex;

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (!isCurrentPage) return false;

                  final pixels = notification.metrics.pixels;
                  final newScale = _calculateScale(pixels);
                  if (newScale != _currentScale) {
                    setState(() => _currentScale = newScale);
                  }

                  final atTop = pixels <= 0.1;

                  if (_enableHorizontalScroll != atTop) {
                    setState(() => _enableHorizontalScroll = atTop);
                  }

                  return false;
                },
                child: SingleChildScrollView(
                  physics: isCurrentPage
                      ? const ClampingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: topGap),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:
                            IosExpendCardRaw(date: widget.dates[actualIndex]),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ]));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
