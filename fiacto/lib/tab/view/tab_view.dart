part of 'view.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  void initState() {
    super.initState();
    // context.read<FocalPersonCubit>().init(context.read<AuthRepository>().currentUser);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTab());
  }

  void _updateTab() {
    final tab = _tabFromRoute;
    if (tab != null) {
      context.read<TabCubit>().onTabChanged(tab, GoRouter.of(context));
    }
  }

  TabItem? get _tabFromRoute =>
      TabItem.fromName(context.getRouteArgument('page'));

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: BlocBuilder<TabCubit, TabState>(
        builder: (context, state) {
          return Scaffold(
            body: _TabBody(state.currentTab),
            bottomNavigationBar: _BottomNavBar(currentTab: state.currentTab),
          );
        },
      ),
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody(this.currentTab);

  final TabItem currentTab;

  @override
  Widget build(BuildContext context) {
    switch (currentTab) {
      case TabItem.home:
        return const DashboardPage();
      case TabItem.card:
        return const CardPage();
      case TabItem.benefit:
        return const BenefitPage();
      case TabItem.discover:
        return const DiscoverPage();
    }
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentTab});

  final TabItem currentTab;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      selectedIndex: currentTab.$index,
      elevation: 11,
      shadowColor: Colors.black,
      indicatorColor: Colors.transparent,
      destinations: TabItem.items.map(_buildItemView).toList(),
      height: 56,
    );
  }

  Widget _buildItemView(TabItem tab) =>
      _TabItemView(tab, selected: tab == currentTab);
}

class _TabItemView extends StatelessWidget {
  const _TabItemView(this.tab, {this.selected = false});

  final TabItem tab;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomInkWell(
        pressedOpacity: 0.4,
        onTap: () {
          context.read<TabCubit>().onTabChanged(tab, GoRouter.of(context));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetIcon.monotone(
              tab.icon,
              size: 24,
              color: selected ? context.primary500 : context.grey500,
            ),
            Text(
              tab.title,
              style: context.twelve500.copyWith(
                color: selected ? context.primary500 : context.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
