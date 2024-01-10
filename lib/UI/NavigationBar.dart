import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarWidget extends StatefulWidget {
  List navBtn;
  NavigationBarWidget({super.key, required this.navBtn});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(17.0),
          topRight: Radius.circular(17.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < widget.navBtn.length; i++)
            GestureDetector(
              onTap: () {
                pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                setState(() => selectBtn = i);
              },
              child: Container(child: iconBtn(i)),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 10.0 : 0.0;
    var width = isActive ? 10.0 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              margin: const EdgeInsets.only(top: 5),
              height: height,
              width: width,
              duration: const Duration(milliseconds: 500),
              decoration: isActive
                  ? const BoxDecoration(
                      color: classColors.bgColor, shape: BoxShape.circle)
                  : null,
            ),
          ),
          Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.navBtn[i][1],
                    colorFilter: ColorFilter.mode(
                        isActive
                            ? Colors.blueAccent
                            : classColors
                                .NEUTRAL(modeControll.ThemeModeValue)[0],
                        BlendMode.srcIn),
                    height: 21,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUnit.Textspcfic(
                      text: widget.navBtn[i][0],
                      color: isActive ? classColors.bgColor : Colors.black45,
                      maxLines: 1,
                      size: 11)
                ],
              ))
        ],
      ),
    );
  }
}
