import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class SideBarPage extends StatelessWidget {
  final Function onTapMenu;
  const SideBarPage({required this.onTapMenu, Key? key}) : super(key: key);

  Widget _renderMenu(
      {required String label, required String asset, required Function onTap}) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.025,
                left: size.width * 0.46,
                child: GestureDetector(
                  onTap: () {
                    onTapMenu();
                  },
                  child: Image.asset(
                    "assets/img/arrow-back.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Image.asset("assets/img/arrow-back.png"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Flexible(
                      child: Text(
                        "Rida Sukmara",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _renderMenu(
                        label: "Analitycs",
                        asset: "assets/icons/analityc.svg",
                        onTap: () {}),
                    _renderMenu(
                        label: "Categories",
                        asset: "assets/icons/category.svg",
                        onTap: () {}),
                    _renderMenu(
                        label: "Settings",
                        asset: "assets/icons/setting.svg",
                        onTap: () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowMenu = false;

  void toggleShowMenu() {
    setState(() {
      isShowMenu = !isShowMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBlue,
      body: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeInQuad,
            width: size.width,
            height: size.height,
            left: isShowMenu ? 0 : -size.width,
            duration: const Duration(milliseconds: 300),
            child: SideBarPage(
              onTapMenu: toggleShowMenu,
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeInQuad,
            top: isShowMenu ? size.height * 0.06 : 0,
            left: isShowMenu ? size.width * 0.70 : 0,
            height: isShowMenu ? size.height * 0.88 : size.height,
            width: size.width,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: isShowMenu,
              child: DashboardPage(
                onTapMenu: toggleShowMenu,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final Function onTapMenu;
  const DashboardPage({
    required this.onTapMenu,
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ScrollController todayListController = ScrollController();
  bool isHideSliderCategory = false;

  @override
  void initState() {
    super.initState();
    todayListController.addListener(() {
      setState(() {
        isHideSliderCategory = todayListController.offset > 10;
      });
    });
  }

  @override
  void dispose() {
    todayListController.dispose();
    super.dispose();
  }

  Widget _searchBar({
    required Function onTapMenu,
    required Function onTapSearch,
    required Function onTapNotification,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            onTapMenu();
          },
          child: Image.asset(
            "assets/img/menu.png",
            width: 26,
            height: 26,
            fit: BoxFit.contain,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onTapSearch();
              },
              child: Image.asset(
                "assets/img/search.png",
                width: 26,
                height: 26,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () {
                onTapNotification();
              },
              child: Image.asset(
                "assets/img/notification.png",
                width: 26,
                height: 26,
                fit: BoxFit.contain,
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBlue,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromRGBO(250, 251, 255, 1),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _searchBar(
                onTapMenu: widget.onTapMenu,
                onTapSearch: () {},
                onTapNotification: () {},
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                "What's up Rida!",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isHideSliderCategory ? 0 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: size.width,
                  height: isHideSliderCategory ? 0 : size.width * 0.4,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        const Text(
                          "CATEGORIES",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: size.width,
                          height: 130,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 16.0,
                                  top: 4,
                                  bottom: 4,
                                ),
                                child: Container(
                                  height: 100,
                                  width: 220,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 0.1,
                                        spreadRadius: 0.2,
                                        blurStyle: BlurStyle.outer,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Flexible(
                                          child: Text(
                                            "40 Tasks",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  167, 167, 167, 1),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Flexible(
                                          child: Text(
                                            "Bussiness Class Firest Firels",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 200,
                                                height: 3,
                                                color: const Color.fromRGBO(
                                                    237, 238, 248, 1),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 3,
                                                decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blue,
                                                      offset: Offset(0, 2),
                                                      blurRadius: 1,
                                                      spreadRadius: 0.5,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text("TODAY'S TASKS"),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  controller: todayListController,
                  itemCount: 15,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        width: size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.5, 0.5),
                              blurRadius: 8,
                              spreadRadius: 0.2,
                              blurStyle: BlurStyle.inner,
                            )
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                  "Meeting with Bos And the balh balh ablan lbal abla blabla alblab"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
