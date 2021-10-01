import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import '../../../data/models/onboard_item.dart';

class OnboardController extends ChangeNotifier {
  final List<OnboardItem> items = [
    OnboardItem(
      image: 'assets/pages/onboard/onboard1.svg',
      title: 'Keep your Sunny Days!',
      description: 'Quisque ac vehicula dui. Vivamus ac dapibus erat. Praesent mollis, leo vel iaculis volutpat, metus ligula efficitur orci, id auctor tellus lectus venenatis justo. Ut sem dolor, congue vel felis in, egestas feugiat lacus.',
    ),
    OnboardItem(
      image: 'assets/pages/onboard/onboard2.svg',
      title: 'Leave us in the rain',
      description: ' Duis blandit nunc id mauris volutpat tincidunt. Integer convallis finibus ipsum, a mattis mi auctor nec. Vestibulum vel justo semper, tincidunt sapien ut, ornare duis.',
    ),
    OnboardItem(
      image: 'assets/pages/onboard/onboard3.svg',
      title: 'Empecemos!',
      description: 'Mauris a eros metus. Sed ac scelerisque nibh. Quisque interdum efficitur purus ac facilisis. Praesent efficitur consequat sem eget tempus. Donec rhoncus nibh eu purus dapibus, nec ornare purus viverra.',
    )
  ]; 

  final PageController pageController = PageController();
  double _currentPage = 0;
  double get currentPage => _currentPage;

  void afterFirstLayout(){
    pageController.addListener(() { 
      
      final double page = pageController.page!;
        _currentPage = page;
        notifyListeners();
      // if(page! % 1 == 0 && _currentPage != page){
      //   notifyListeners();
      //   print(page);
      // }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
