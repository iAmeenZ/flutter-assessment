import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBotNav extends StatefulWidget {
  final Function(int) onChange;
  final List<IconData> iconList;
  final int defaultIndex;
  final Color? lineColor;
  final Color? gradientColor;
  const CustomBotNav({
    Key? key,
    this.gradientColor,
    this.lineColor,
    required this.defaultIndex,
    required this.iconList,
    required this.onChange
  }) : super(key: key);

  @override
  State<CustomBotNav> createState() => _CustomBotNavState();
}

class _CustomBotNavState extends State<CustomBotNav> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onChange(index);
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: 50,
          decoration: index == _selectedIndex ? BoxDecoration(
            border: Border(
              top: BorderSide(width: 4, color: widget.lineColor ?? Get.theme.primaryColor),
            ),
            // gradient: LinearGradient(
            //   colors: [
            //     widget.gradientColor != null ? widget.gradientColor!.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
            //     widget.gradientColor != null ? widget.gradientColor!.withOpacity(0) :Colors.orange.withOpacity(0),
            //   ],
            //   begin: Alignment.bottomCenter, end: Alignment.topCenter
            // )
            ) : BoxDecoration(),
          child:Icon(
            icon,
            color: index == _selectedIndex ? Theme.of(context).iconTheme.color : Colors.grey,
          )
        ),
      ),
    );
  }
}