
enum NavItemEnum{
  home("/home"),
  search("/search"),
  favorite("/favorite"),
  cart("/cart"),
  profile("/profile");

  const NavItemEnum(this.name);
  final String name;
}