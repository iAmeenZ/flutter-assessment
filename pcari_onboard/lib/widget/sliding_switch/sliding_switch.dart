import 'package:flutter/material.dart';

class SlidingSwitchCustom1 extends StatefulWidget {
  final double height;
  final ValueChanged<bool> onChanged;
  final double width;
  final bool isCustom;
  final String textOff;
  final String textOn;
  final Duration animationDuration;
  final Color colorOn;
  final Color colorOff;
  final Color background;
  final Color buttonColor;
  final Color inactiveColor;
  final bool isEnable;
  final Function onTap;
  final Function onSwipe;

  const SlidingSwitchCustom1({
    Key? key,
    required this.isEnable,
    required this.isCustom,
    required this.onChanged,
    this.height = 55,
    this.width = 250,
    this.animationDuration = const Duration(milliseconds: 400),
    required this.onTap,
    required this.onSwipe,
    this.textOff = "Off",
    this.textOn = "On",
    this.colorOn = const Color(0xffdc6c73),
    this.colorOff = const Color(0xff6682c0),
    this.background = const Color(0xffe4e5eb),
    this.buttonColor = const Color(0xfff7f5f7),
    this.inactiveColor = const Color(0xff636f7b),
  }) : super(key: key);
  @override
  _SlidingSwitchCustom1 createState() => _SlidingSwitchCustom1();
}

class _SlidingSwitchCustom1 extends State<SlidingSwitchCustom1>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double value = 0.0;

  late bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.isCustom;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.isEnable ? () {
          _action();
          widget.onTap();
        } : () {{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Turn on notifications first.")));}},
        onPanStart: widget.isEnable ? (details) {
          _action();
          widget.onSwipe();
        } : (_) {{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Turn on notifications first.")));}},
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadius.circular(50)),
          padding: const EdgeInsets.all(2),
          child: Stack(children: <Widget>[
            Transform.translate(
                offset: Offset(((widget.width * 0.5) * value - (2 * value)), 0),
                child: Container(
                  height: widget.height,
                  width: widget.width * 0.5 - 4,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      color: widget.buttonColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 5),
                          blurRadius: 10.0,
                        ),
                      ]),
                )),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.textOff,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: turnState? widget.inactiveColor : widget.colorOff, fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.textOn,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: turnState ? widget.colorOn : widget.inactiveColor, fontSize: 15),
                    ),
                  ),
                )
              ],
            )
          ]),
        ));
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();
      if (changeState) widget.onChanged(turnState);
    });
  }
}
