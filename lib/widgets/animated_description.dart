import 'package:flutter/material.dart';

class AnimatedDescription extends StatelessWidget {
  final bool isExpanded;
  final String data;

  const AnimatedDescription({super.key, required this.isExpanded, required this.data});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedCrossFade(
        crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: kThemeAnimationDuration,
        firstChild: Text(
          data,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
        ),
        secondChild: SizedBox.shrink(),
      ),
    );
  }
}
