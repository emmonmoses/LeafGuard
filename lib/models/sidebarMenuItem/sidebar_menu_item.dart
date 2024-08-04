class Item {
  String headerText;
  bool isExpanded;
  bool isOpen;

  Item({
    required this.headerText,
    this.isExpanded = true,
    this.isOpen = false,
  });
}

class Role {
  String create;
  String access;
  String delete;

  Role({
    required this.create,
    required this.access,
    required this.delete,
  });
}

List<Item> sidebarMenuItems = [
  Item(
    headerText: 'Dashboard',
  ),
  Item(
    headerText: 'Monitors',
  ),
  Item(
    headerText: 'Monitoring Statuses',
  ),
  Item(
    headerText: 'Admins',
  ),
  Item(
    headerText: 'Sub Admins',
  ),
  Item(
    headerText: 'Individuals',
  ),
  Item(
    headerText: 'Organisations',
  ),
  Item(
    headerText: 'Tree Types',
  ),
  Item(
    headerText: 'Trees Received',
  ),
  Item(
    headerText: 'Planting Schedule',
  ),
  Item(
    headerText: 'Monitoring Schedule',
  ),
];

List<Role> roles = [
  Role(
    create: 'create',
    access: 'access',
    delete: 'delete',
  ),
];
