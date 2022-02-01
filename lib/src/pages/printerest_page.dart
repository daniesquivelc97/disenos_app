import 'package:disenos_app/src/widgets/printeres_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PrinterestPage extends StatelessWidget {
  const PrinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              PrinterestGrid(),
              const _PrinterestMenuLocation(),
            ],
          ),
          // body: SafeArea(
          //   child: PrinterestMenu(),
          // ),
        ),
      ),
    );
  }
}

class _PrinterestMenuLocation extends StatelessWidget {
  const _PrinterestMenuLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    return Positioned(
      bottom: 30,
      child: Container(
        width: widthPantalla,
        child: Align(
          child: PrinterestMenu(
            mostrar: mostrar,
            items: [
              PrinteresButton(
                  onPressed: () {
                    print('Icon pie_chart');
                  },
                  icon: Icons.pie_chart),
              PrinteresButton(
                  onPressed: () {
                    print('Icon search');
                  },
                  icon: Icons.search),
              PrinteresButton(
                  onPressed: () {
                    print('Icon notifications');
                  },
                  icon: Icons.notifications),
              PrinteresButton(
                  onPressed: () {
                    print('Icon supervised_user_circle');
                  },
                  icon: Icons.supervised_user_circle),
            ],
            // backgoundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}

class PrinterestGrid extends StatefulWidget {
  PrinterestGrid({Key? key}) : super(key: key);

  @override
  State<PrinterestGrid> createState() => _PrinterestGridState();
}

class _PrinterestGridState extends State<PrinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);
  ScrollController controller = ScrollController();
  double scrollAnterior = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > scrollAnterior) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => _PinterestItem(index: index),
        childCount: items.length,
      ),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
