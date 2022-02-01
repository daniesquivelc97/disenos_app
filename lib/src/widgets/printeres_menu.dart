import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrinteresButton {
  final Function() onPressed;
  final IconData icon;

  PrinteresButton({required this.onPressed, required this.icon});
}

class PrinterestMenu extends StatelessWidget {
  final bool mostrar;
  final Color backgoundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PrinteresButton> items;

  PrinterestMenu({
    Key? key,
    this.mostrar = true,
    this.backgoundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.blueGrey,
    required this.items,
  }) : super(key: key);

  // final List items = [
  //   PrinteresButton(
  //       onPressed: () {
  //         print('Icon pie_chart');
  //       },
  //       icon: Icons.pie_chart),
  //   PrinteresButton(
  //       onPressed: () {
  //         print('Icon search');
  //       },
  //       icon: Icons.search),
  //   PrinteresButton(
  //       onPressed: () {
  //         print('Icon notifications');
  //       },
  //       icon: Icons.notifications),
  //   PrinteresButton(
  //       onPressed: () {
  //         print('Icon supervised_user_circle');
  //       },
  //       icon: Icons.supervised_user_circle),
  // ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: mostrar ? 1 : 0,
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_MenuModel>(context).backgoundColor = backgoundColor;
              Provider.of<_MenuModel>(context).activeColor = activeColor;
              Provider.of<_MenuModel>(context).inactiveColor = inactiveColor;
              return _PrinterestMenuBackground(
                child: _MenuItems(items),
              );
            },
          )),
    );
  }
}

class _PrinterestMenuBackground extends StatelessWidget {
  final Widget child;

  const _PrinterestMenuBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Provider.of<_MenuModel>(context).backgoundColor;

    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        boxShadow: const [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(10, 10),
              blurRadius: 10,
              spreadRadius: -5)
        ],
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List menuItems;

  const _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (index) => _PrinterestMenuButton(
          index,
          menuItems[index],
        ),
      ),
    );
  }
}

class _PrinterestMenuButton extends StatelessWidget {
  final int index;
  final PrinteresButton item;
  const _PrinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final menuModel = Provider.of<_MenuModel>(context);

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: itemSeleccionado == index ? 35 : 25,
          color: itemSeleccionado == index
              ? menuModel.activeColor
              : menuModel.inactiveColor,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color backgoundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => _itemSeleccionado;

  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
