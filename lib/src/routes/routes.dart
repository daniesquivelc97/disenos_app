import 'package:disenos_app/src/pages/emergency_page.dart';
import 'package:disenos_app/src/pages/graficas_circulares_page.dart';
import 'package:disenos_app/src/pages/headers_page.dart';
import 'package:disenos_app/src/pages/printerest_page.dart';
import 'package:disenos_app/src/pages/slider_list_page.dart';
import 'package:disenos_app/src/pages/slideshow_page.dart';
import 'package:disenos_app/src/retos/cuadrado_animado_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageRoutes = <_Route>[
  _Route(
    FontAwesomeIcons.slideshare,
    'Slideshow',
    const SlideshowPage(),
  ),
  _Route(
    FontAwesomeIcons.ambulance,
    'Emergencia',
    const EmergencyPage(),
  ),
  _Route(
    FontAwesomeIcons.heading,
    'Encabezados',
    HeadersPage(),
  ),
  _Route(
    FontAwesomeIcons.slideshare,
    'Cuadro Animado',
    const CuadradoAnimadoPage(),
  ),
  _Route(
    FontAwesomeIcons.circleNotch,
    'Barra Progreso',
    const GraficasCircularesPage(),
  ),
  _Route(
    FontAwesomeIcons.pinterest,
    'Pinterest',
    const PrinterestPage(),
  ),
  _Route(
    FontAwesomeIcons.mobile,
    'Slivers',
    const SliderListPage(),
  ),
];

class _Route {
  final IconData icon;
  final String titulo;
  final Widget page;

  _Route(this.icon, this.titulo, this.page);
}
