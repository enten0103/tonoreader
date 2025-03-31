import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    String str =
        '''文文绰号的由来就是他的那个气场。\n他挺拔的姿态仿佛背后有撑着一根柱子，整洁合身的制服和庄严的举止能让人联想到武士或文文绰号的由来就是他的那个气场\n。他挺拔的姿态仿佛背后有撑着一根柱子，整洁合身的制服和庄严的举止能让人联想到武士或军人''';
    print(predictTextLines(text: str, fontSize: 18.25, containerWidth: 361));
    final textSpan = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: 18,
        height: 1.5,
      ),
    );
    return SafeArea(
      child: Center(
          child: Container(
              width: 361,
              child: LayoutBuilder(builder: (ctx, cts) {
                return Column(children: [
                  LastLinesText(
                    text: str,
                    maxLines: 3,
                  )
                ]);
              }))),
    );
  }

  int predictTextLines({
    required String text,
    required double fontSize,
    required double containerWidth,
  }) {
    if (containerWidth <= 0 || fontSize <= 0 || text.isEmpty) {
      return 0;
    }

    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        height: 1.5,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr, // 或根据实际文本方向设置
    );
    textPainter.layout(maxWidth: containerWidth);
    print(textPainter.size);
    var text1 = textPainter.computeLineMetrics()[1];
    print(text1.width);
    return textPainter.computeLineMetrics().length;
  }
}

class LastLinesText extends StatelessWidget {
  final String text; // 输入的完整文本
  final int maxLines; // 最大显示行数
  final TextStyle style; // 文本样式

  const LastLinesText({
    super.key,
    required this.text,
    required this.maxLines,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 创建 TextSpan 用于测量文本
        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
        );
        // 设置最大宽度并布局
        tp.layout(maxWidth: constraints.maxWidth);

        // 获取文本的总行数
        final lineMetrics = tp.computeLineMetrics();
        final numLines = lineMetrics.length;

        // 如果总行数小于等于 maxLines，直接显示全部文本
        if (numLines <= maxLines) {
          return Text(text, style: style);
        } else {
          final startOffset = tp
              .getLineBoundary(TextPosition(
                  offset: tp
                      .getOffsetForCaret(
                          TextPosition(offset: numLines - maxLines), Rect.zero)
                      .dx
                      .toInt()))
              .end;
          final endOffset = text.length;
          final lastLinesText = text.substring(startOffset, endOffset);
          return Text(lastLinesText, style: style);
        }
      },
    );
  }
}
