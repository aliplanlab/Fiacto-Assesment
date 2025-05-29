// ignore_for_file: constant_identifier_names

enum AssetIcons {
  deposit,
  send,
  convert,
  withdraw,
  visa_logo,
  bitcoin,
  ethereum,
  trade_up,
  avatar,
  home_icon,
  credit_card,
  benefit_icon,
  discover,
  drawer,

  approve_tick,
  ac_icon,
  area_icon,
  alert,
  app_logo,
  authenticator_app,
  apple_icon,
  arrow_left,
  arrow_right,
  Avatar,

  bedroom_icon,
  blank,
  bathroom_icon,

  copy_icon,
  close_tick,
  cat_icon,
  check_box,
  check_circle,
  cross_mark,
  check_mark,
  calender_icon,

  dot,
  delete_icon,
  deals,
  download_icon,
  down_arrow,
  dog_vector_icon,
  dollar_icon,
  dropdown_icon,
  drop_up,
  direction_icon,
  dishwasher_icon,

  edit,
  elevator_icon,
  electricity_icon,

  exclamation_icon,
  education,

  furnished_icon,
  facebook_icon,
  food,
  favorite_filled_icon,
  fireplace_icon,
  fitness_center,

  google_icon,
  gallery_icon,
  gas_icon,
  gated_entry_icon,

  help_center,
  heat_icon,
  home_other,

  inspections,

  jpg_icon,

  live_photos,
  line,
  logout,
  like_icon,
  listings,
  loft,

  messages,
  menu,
  message_icon,
  mail,
  min_arrow_left,
  min_arrow_right,
  meet,

  new_message,
  no_smoking_icon,
  new_password_icon,

  offers,

  photography_service,
  password_visibility,
  phone_icon,
  password_eye,
  photos,
  play_icon,
  pause_icon,
  pool_icon,
  pdf_icon,
  png_icon,
  plus_icon,

  remove_icon,
  recreation_icon,

  settings,
  swimming_pool_icon,
  storage_icon,
  search,
  share_icon,
  star_icon,
  search_icon,
  square_feet,

  tabler_plane,
  tabler_alert_circle_filled,

  us,
  upload_icon,
  underground_subway_icon,

  verified_shield_icon,
  video,
  virtual_tour,
  video_icon,
  verified_circle,

  water_icon,
  wheelchair_icon;

  factory AssetIcons.fromName(String? name) => AssetIcons.values.firstWhere(
        (e) => e.name == name,
        orElse: () => AssetIcons.blank,
      );
}

enum AssetIconType {
  monotone,
  multicolor,
  ;

  static const all = values;
}

extension AssetIconsX on AssetIcons {
  static const String _basePath = 'assets/icons';

  String asset(AssetIconType type) => '$_basePath/$name.svg';
}
