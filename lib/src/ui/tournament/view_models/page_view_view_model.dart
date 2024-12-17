import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class PageViewViewModel extends ChangeNotifier {
  late int _page;

  // final int _numberOfPages;
  final PageController _pageController;
  final _log = Logger('PageViewViewModel');
  PageViewViewModel(PageController pageController)
      : _pageController = pageController {
    _page = _pageController.initialPage;
    //emit(_pageController.initialPage);
    //animateToPage(_page);
  }

  PageController get pageController => _pageController;
  int get page => _page;

  animateToPage(int page) {
    // _log.fine('animateToPage $page');
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    emit(page);
  }

  emit(int page) {
    //_log.fine('emit page $page');
    _page = page;
    notifyListeners();
  }
}
