import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AMCHomePage());
}

class AMCHomePage extends StatelessWidget {
  const AMCHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    doWhenWindowReady(
      () {
        appWindow.size = Size(900, 650);
        appWindow.minSize = Size(900, 650);
        appWindow.title = "Aerell Addon Creator";
        appWindow.show();
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomePageProvider(),
        child: Scaffold(
          body: Stack(
            children: [
              Row(
                children: [LeftSide(), RightSide()],
              ),
              Column(
                children: [
                  WindowTitleBar(
                    title: "Welcome To Aerell Addon Creator",
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class WindowTitleBar extends StatelessWidget {
  String title;

  WindowTitleBar({super.key, this.title = "Aerell Addon Creator"});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
        child: Container(
      color: HexColor("3C3F41"),
      child: Row(
        children: [
          Expanded(
              child: MoveWindow(
            child: Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Container(
                  height: 15,
                  width: 15,
                  child: Image.asset(
                    "assets/app_icon.ico",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                )
              ],
            ),
          )),
          MinimizeWindowButton(
            colors: WindowButtonColors(
                iconNormal: Colors.white, mouseOver: Colors.black),
          ),
          MaximizeWindowButton(
            colors: WindowButtonColors(
                iconNormal: Colors.white, mouseOver: Colors.black),
          ),
          CloseWindowButton(
            colors: WindowButtonColors(
                iconNormal: Colors.white,
                mouseOver: Colors.red,
                mouseDown: Color.fromARGB(255, 235, 98, 88)),
          )
        ],
      ),
    ));
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    return SizedBox(
      width: 270,
      child: Container(
        color: HexColor("3C3F41"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/app_icon.ico",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aerell Minecraft Creator",
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      Text("Versi 1.0 Alpha",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)))
                    ],
                  )
                ],
              ),
            ),
            Consumer<HomePageProvider>(
              builder: (context, value, child) => LeftSideButton(
                selected: (value.LeftSideButtonSelected == 0) ? true : false,
                text: "Projects",
                onTap: () {
                  homePageProvider.setButtonSelected(0);
                  homePageProvider.setScreenSelected(Projects());
                },
              ),
            ),
            Consumer<HomePageProvider>(
              builder: (context, value, child) => LeftSideButton(
                selected: (value.LeftSideButtonSelected == 1) ? true : false,
                text: "Customize",
                onTap: () {
                  homePageProvider.setButtonSelected(1);
                  homePageProvider.setScreenSelected(Customize());
                },
              ),
            ),
            Consumer<HomePageProvider>(
              builder: (context, value, child) => LeftSideButton(
                selected: (value.LeftSideButtonSelected == 2) ? true : false,
                text: "Plugins",
                onTap: () {
                  homePageProvider.setButtonSelected(2);
                  homePageProvider.setScreenSelected(Plugins());
                },
              ),
            ),
            Consumer<HomePageProvider>(
              builder: (context, value, child) => LeftSideButton(
                selected: (value.LeftSideButtonSelected == 3) ? true : false,
                text: "Learn Aerell Minecraft Creator",
                onTap: () {
                  homePageProvider.setButtonSelected(3);
                  homePageProvider.setScreenSelected(Learn());
                },
              ),
            ),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  print("Settings Button");
                },
                icon: Icon(
                  Icons.settings,
                  color: HexColor("788288"),
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}

class LeftSideButton extends StatelessWidget {
  bool selected;
  Function() onTap;
  String text;
  LeftSideButton(
      {super.key,
      this.text = "Text Button",
      this.selected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 45,
        color:
            (selected) ? Color.fromARGB(255, 168, 53, 44) : Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 35,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: HexColor("313335"),
      child: Consumer<HomePageProvider>(
        builder: (context, value, child) => value.screen,
      ),
    ));
  }
}

class HomePageProvider with ChangeNotifier {
  Widget _screen = Projects();
  int _LeftSideButtonSelected = 0;

  int get LeftSideButtonSelected => _LeftSideButtonSelected;

  Widget get screen => _screen;

  setButtonSelected(int selected) {
    _LeftSideButtonSelected = selected;
    notifyListeners();
  }

  setScreenSelected(Widget screen) {
    _screen = screen;
    notifyListeners();
  }
}

//Screen
class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Project",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Customize extends StatelessWidget {
  const Customize({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Customize",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Plugins extends StatelessWidget {
  const Plugins({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Plugins",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Learn extends StatelessWidget {
  const Learn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Help and Resource",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
