part of 'models.dart';

enum TabItem {
  home(AssetIcons.home_icon),
  card(AssetIcons.credit_card),
  benefit(AssetIcons.benefit_icon),
  discover(AssetIcons.discover);

  const TabItem(this.icon);
  final AssetIcons icon;

  String get title {
    switch (this) {
      case TabItem.home:
        return 'Home';
      case TabItem.card:
        return 'Card';
      case TabItem.benefit:
        return 'Benefit';
      case TabItem.discover:
        return 'Discover';
    }
  }

  String get path => 'tab/$name';

  int get $index => items.indexOf(this);

  static const List<TabItem> items = [
    home,
    card,
    benefit,
    discover,
    // blank,
  ];

  static TabItem? fromName(String? name) =>
      name?.notBlank == null
          ? null
          : items.firstWhereOrNull((e) => e.name == name);
}

extension IterableExtension<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
