import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class LoadeingWidget extends StatefulWidget {
  String error;
  bool isLoadeing;
  Widget child;
  Function reloade;
  LoadeingWidget(
      {super.key,
      required this.isLoadeing,
      required this.error,
      required this.reloade,
      required this.child});

  @override
  State<LoadeingWidget> createState() => _LoadeingWidgetState();
}

class _LoadeingWidgetState extends State<LoadeingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoadeing) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (widget.error.isNotEmpty) {
      return InkWell(
        onTap: () {
          widget.reloade();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.replay,
              color: classColors.STATICS(modeControll.ThemeModeValue)[3],
              size: 21,
            ),
            const SizedBox(
              height: 5,
            ),
            TextUnit.TextTitel(
                text: widget.error,
                color: classColors.STATICS(modeControll.ThemeModeValue)[3])
          ],
        ),
      );
    }
    return widget.child;
  }
}
