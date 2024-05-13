import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dashboard.dart';
import 'notification.dart';

class CommonNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonNavBar({Key? key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: theme.primaryColor,
      centerTitle: true,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 32.0,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: 'https://i.postimg.cc/02pnpHXG/logo-1.png',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: MediaQuery.of(context).size.width * 0.05,
              // Reduced to 5% of screen width
              fit: BoxFit.scaleDown,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 32.0,
                ),
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 0),
                    // position where you want to show the menu
                    items: [
                      PopupMenuItem(
                        child: Container(
                          color: Colors.white,
                          // Set the background color to white
                          child: NotificationPage(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
