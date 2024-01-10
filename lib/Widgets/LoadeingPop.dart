import 'package:flutter/material.dart';

class LoadeingPop extends StatefulWidget {
  Widget child;
  bool isLoageing;

  LoadeingPop({super.key, required this.child, required this.isLoageing});

  @override
  State<LoadeingPop> createState() => _LoadeingPopState();
}

class _LoadeingPopState extends State<LoadeingPop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoageing)
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(.4),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
      ],
    );
  }
}
