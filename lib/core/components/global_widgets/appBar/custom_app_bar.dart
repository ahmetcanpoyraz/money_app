import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/core/components/changeLang/change_lang.dart';
import 'package:money_app/core/init/navigation/navigation_service.dart';
import 'package:provider/provider.dart';
import '../../../init/provider/theme_provider.dart';
import '../../circular_close/circular_close_button.dart';
import '../changeTheme/change_theme_button_widget.dart';

class AppBarCustom extends StatefulWidget with PreferredSizeWidget {
  const AppBarCustom(
      {Key? key,
      required this.title,
      this.showBackButton,
      this.showChangeLang,
      this.showCircularCloseButton,
      this.showChangeThemeButton})
      : super(key: key);
  final String? title;
  final bool? showBackButton;
  final bool? showChangeLang;
  final bool? showCircularCloseButton;
  final bool? showChangeThemeButton;
  @override
  State<AppBarCustom> createState() => _AppBarCustomState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(44.0.h);
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: context.watch<ThemeProvider>().isDarkMode
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor, // Status bar
      ),
      automaticallyImplyLeading: false,
      leadingWidth: widget.showChangeLang != null && widget.showChangeLang == true ? 100.w : 40.w,
      leading: widget.showBackButton != null && widget.showBackButton == true
          ? InkWell(
              onTap: () {
                NavigationService.instance.popPage();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 16.h,
              ),
            )
          :  widget.showChangeLang != null && widget.showChangeLang == true
          ? ChangeLangWidget()
          : const SizedBox(),
      elevation: 0,
      actions: [
        widget.showBackButton != null && widget.showBackButton == true
            ? const SizedBox()
            : const SizedBox(),
        widget.showChangeThemeButton != null &&
                widget.showChangeThemeButton == true
            ? ChangeThemeButtonWidget()
            : const SizedBox(),
        widget.showCircularCloseButton != null &&
                widget.showCircularCloseButton == true
            ? CircularCloseButton()
            : const SizedBox(),
      ],
      actionsIconTheme: IconThemeData(
        size: 16.h,
      ),
      title: widget.title != null
          ? Text(
          widget.title!,
          style: Theme.of(context).textTheme.headline3,
            )
          : const Text(""),
      centerTitle: true,
      toolbarHeight: 44.h,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
