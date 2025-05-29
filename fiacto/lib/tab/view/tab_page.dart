part of 'view.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key, required this.page});

  final String page;

  static String path() => '/tab/:page';

  static String routeWithFirstTab() => route(_firstTab);

  static String routeWithPath(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) => RouteUri.path(path, routes: routes, query: query, refresh: refresh);

  static String routeWithPage(
    String page, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) => routeWithPath(
    'tab/$page',
    routes: routes,
    query: query,
    refresh: refresh,
  );

  static String route(
    TabItem tab, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) => routeWithPage(tab.name, routes: routes, query: query, refresh: refresh);

  static TabItem get _firstTab => TabItem.items.first;

  TabItem get _resolvedTabFromPage => TabItem.fromName(page) ?? _firstTab;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabCubit(initialTab: _resolvedTabFromPage),
        ),
      ],
      child: const TabView(),
    );
  }
}

extension ChangeTabContext on BuildContext {
  void changeTab(TabItem tab) {
    go(TabPage.route(tab));
    try {
      read<TabCubit>().onTabChanged(tab, GoRouter.of(this));
    } catch (_) {}
  }

  TabItem get currentTab => read<TabCubit>().state.currentTab;
}
