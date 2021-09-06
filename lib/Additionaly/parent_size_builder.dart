import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParentSizeBuilder extends StatefulWidget {
  GlobalKey mkey;
  Widget child;

  ParentSizeBuilder({Key key, this.child}) : super(key: key) {
    this.mkey = GlobalObjectKey(this.toString());
  }

  @override
  _ParentSizeBuilderState createState() => _ParentSizeBuilderState();
}

class _ParentSizeBuilderState extends State<ParentSizeBuilder> {
  Size mySize = null;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mySize != null) return;
      RenderBox render = widget.mkey.currentContext.findRenderObject();
      mySize = render.size;
      setState(() {});
    });
    super.initState();
  }

  _ParentSizeBuilderState() {}

  @override
  Widget build(BuildContext context) {
    if (mySize == null)
      return Container(
        key: widget.mkey,
      );
    else
      return SizedBox(
        width: mySize.width,
        height: mySize.height,
        child: widget.child,
      );
  }
}
