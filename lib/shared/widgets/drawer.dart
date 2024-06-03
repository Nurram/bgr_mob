import 'package:bgr_logistik/core_imports.dart';

import '../../models/role_permission_response.dart';

class DrawerWidget extends StatelessWidget {
  final String name;
  final String role;
  final List<String> titles;
  final int currentIndex;
  final List<RolePermissionDatum> permission;
  final Function(int) onTap;

  const DrawerWidget({
    super.key,
    required this.name,
    required this.role,
    required this.titles,
    required this.currentIndex,
    required this.permission,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    permission.add(
      RolePermissionDatum(name: 'Logout', isActive: 1, id: 1),
    );
    
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .5,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: StyleText.textWhite(fontWeight: FontWeight.w600),
              ),
              Text(
                'Role: $role',
                style: StyleText.textWhite(),
              ),
            ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...titles.map(
                (e) {
                  final index = titles.indexOf(e);

                  return Visibility(
                    visible: permission
                            .firstWhere((element) => element.name == e)
                            .isActive ==
                        1,
                    child: InkWell(
                      onTap: () {
                        onTap(index);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .5,
                        padding: const EdgeInsets.all(16),
                        color: index == currentIndex
                            ? Theme.of(context).primaryColor.withAlpha(50)
                            : Colors.transparent,
                        child: Text(
                          e,
                          style: StyleText.textBlack(
                            fontWeight: index == currentIndex
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
