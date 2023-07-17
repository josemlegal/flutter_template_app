import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template_app/core/theme/app_theme.dart';
import 'package:flutter_template_app/views.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabsView extends StatefulHookConsumerWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<TabsView> {
  bool isLoading = true;

  int _selectedPageIndex = 0;

  final List<Map<String, String>> _routes = [
    {
      'path': '/dashboard',
      'icon': 'assets/images/home_icon.svg',
    },
    {
      'path': '/profile',
      'icon': 'assets/images/profile.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Widget getSelectedPage(int index) {
      switch (index) {
        case 1:
          return const ProfileView();

        default:
          return const TabsView();
      }
    }

    void changeSelectedPageIndex(index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : getSelectedPage(_selectedPageIndex),
        bottomNavigationBar:
            // isVisible?
            BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 8,
          child: Container(
            key: UniqueKey(),
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedFontSize: 0,
                  showSelectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    ..._routes
                        .map((route) => BottomNavigationBarItem(
                              icon: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: _routes.indexOf(route) ==
                                                _selectedPageIndex
                                            ? AppColors.accent
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 11),
                                      height: 4,
                                      width: 30,
                                    ),
                                    SvgPicture.asset(
                                      route['icon']!,
                                      colorFilter: ColorFilter.mode(
                                          _routes.indexOf(route) ==
                                                  _selectedPageIndex
                                              ? AppColors.accent
                                              : AppColors.neutral,
                                          BlendMode.srcIn),
                                      height: 21,
                                    ),
                                  ],
                                ),
                              ),
                              label: "",
                            ))
                        .toList()
                  ],
                  currentIndex: _selectedPageIndex,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.neutral,
                  onTap: (index) {
                    changeSelectedPageIndex(index);
                  },
                ),
              ),
            ),
          ),
        )
        // : null,
        );
  }
}
