import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class ScrollViewWithScrollbars extends StatefulWidget {
  const ScrollViewWithScrollbars({Key? key, required this.child, this.axis = Axis.vertical}) : super(key: key);
  final Widget child;
  final Axis axis;
  @override
  _ScrollViewWithScrollbarsState createState() => _ScrollViewWithScrollbarsState();
}

class _ScrollViewWithScrollbarsState extends State<ScrollViewWithScrollbars> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: context.select((ApplicationState m) => m.touchMode),
      child: SingleChildScrollView(
        scrollDirection: widget.axis,
        controller: _scrollController,
        child: widget.child,
      ),
    );
  }
}
