
enum NavItemEnum{
  home("/home"),
  favorite("/favorite"),
  cart("/cart"),
  profile("/profile");

  const NavItemEnum(this.name);
  final String name;
}