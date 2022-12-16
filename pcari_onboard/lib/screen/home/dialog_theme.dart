import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcari_onboard/constants/theme_mode.dart';
import 'package:pcari_onboard/services/controller/controller.dart';

class DialogThemeSetting extends StatefulWidget {
  const DialogThemeSetting({ Key? key }) : super(key: key);

  @override
  _DialogThemeSettingState createState() => _DialogThemeSettingState();
}

class _DialogThemeSettingState extends State<DialogThemeSetting> {

  int _selectedIndex = 0;

  List<String> modeList = ["Light Mode", "Dark Mode", "System Default"];

  @override
  void initState() {
    super.initState();
    ThemeMode _currentThemeMode = currentThemeMode();
    if (_currentThemeMode == ThemeMode.light) _selectedIndex = 0;
    else if (_currentThemeMode == ThemeMode.dark) _selectedIndex = 1;
    else _selectedIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    List<Icon> iconList = [Icon(Icons.light_mode, size: 21, color: Get.theme.iconTheme.color), Icon(Icons.dark_mode, size: 21, color: Get.theme.iconTheme.color), Icon(Icons.system_update_tv, size: 21, color: Get.theme.iconTheme.color)];
    return AlertDialog(
      backgroundColor: Get.theme.colorScheme.background,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Theme", style: TextStyle(fontWeight: FontWeight.bold, color: Get.theme.textTheme.bodyLarge?.color)),
          IconButton(
            tooltip: 'Close',
            padding: const EdgeInsets.symmetric(horizontal: 5),
            constraints: const BoxConstraints(),
            onPressed: () => Get.close(1),
            icon: Icon(Icons.close, color: Get.theme.iconTheme.color)
          )
        ],
      ),
      content: SizedBox(
        width: 300,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: modeList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  iconList[index],
                  const SizedBox(width: 10),
                  Expanded(child: Text(modeList[index], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8)))),
                ],
              ),
              selected: index == _selectedIndex,
              selectedTileColor: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              trailing: _selectedIndex == index ? Icon(Icons.done, color: Get.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black54) : null,
              onTap: () async {
                _selectedIndex = index;
                ThemeMode newThemeMode = ThemeMode.system;
                if (index == 0) newThemeMode = ThemeMode.light;
                else if (index == 1) newThemeMode = ThemeMode.dark;
                MyController.to.changeThemeMode(themeMode: newThemeMode);
                await Future.delayed(Duration(milliseconds: 300));
                if (mounted) setState(() {});
              },
            );
          }
        )
      ),
    );
  }
}