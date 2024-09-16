import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    // ignore: avoid_print
    print('Please provide a route name to revert.');
    exit(1);
  }

  final routeName = arguments[0];

  removeRouteFromAppRoutes(routeName);
  removeRouteFromAppPages(routeName);
  removeModuleFolder(routeName);
  // ignore: avoid_print
  print('Reverted route $routeName successfully.');
}

void removeRouteFromAppRoutes(String routeName) {
  final routesFile = File('lib/routes/app_routes.dart');

  if (!routesFile.existsSync()) {
    // ignore: avoid_print
    print('app_routes.dart file not found.');
    exit(1);
  }

  var content = routesFile.readAsStringSync();

  // Remove route entries
  content = content.replaceAll(
    RegExp(r"  static const $routeName = _Paths.$routeName;"),
    '',
  );
  content = content.replaceAll(
    RegExp(r"  static const $routeName = '/$routeName';"),
    '',
  );
  content = content.replaceAll(
    RegExp(r"  static const $routeName = '$routeName';"),
    '',
  );
  content = content.replaceAll(
    RegExp(r"  static const $routeName = _Names.$routeName;"),
    '',
  );

  routesFile.writeAsStringSync(content);
  // ignore: avoid_print
  print('Removed route entries from app_routes.dart.');
}

void removeRouteFromAppPages(String routeName) {
  final pagesFile = File('lib/routes/app_pages.dart');

  if (!pagesFile.existsSync()) {
    // ignore: avoid_print
    print('app_pages.dart file not found.');
    exit(1);
  }

  var content = pagesFile.readAsStringSync();

  // Remove import entry and route entry
  content = content.replaceAll(
    RegExp(
        r"import 'package:cabswalle/modules/$routeName/screen/${routeName}_view.dart';\n"),
    '',
  );
  content = content.replaceAll(
    RegExp(r"    GoRoute\(\n      name: Names\.$routeName,.*?    \),\n",
        dotAll: true),
    '',
  );

  pagesFile.writeAsStringSync(content);
  // ignore: avoid_print
  print('Removed route entries from app_pages.dart.');
}

void removeModuleFolder(String moduleName) {
  final moduleDir = Directory('lib/modules/$moduleName');

  if (moduleDir.existsSync()) {
    moduleDir.deleteSync(recursive: true);
    // ignore: avoid_print
    print('Deleted module folder: lib/modules/$moduleName');
  } else {
    // ignore: avoid_print
    print('Module folder lib/modules/$moduleName does not exist.');
  }
}
