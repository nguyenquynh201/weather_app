import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/country_controller.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/container/asset_image.dart';
import 'package:weather_app/view/container/widget/bottomsheet_widget.dart';
import 'package:weather_app/view/container/widget/ui_button_widget.dart';
import 'package:weather_app/view/container/widget/ui_text.dart';
import 'package:weather_app/view/container/widget/ui_underline_textinput.dart';
import 'package:weather_app/view/screen/home/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late TextEditingController _countryController;
  double viewportFraction = 10;
  int _currentPage = 0;
  late PageController _pageController;
  late Timer _timer;
  List image = [
    AssetsImage.imageTroiMua,
    AssetsImage.imageTroiNang,
    AssetsImage.imageTroiRam,
    AssetsImage.imageNgay,
    AssetsImage.imageDem,

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryController = TextEditingController();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UIColors.bg,
      body: SafeArea(
          child: Stack(
        children: [
          PageView.builder(
              controller: _pageController = PageController(viewportFraction: 1),
              itemCount: image.length,
              itemBuilder: (context, index) {
                return imageAnimation(image.elementAt(index), size);
              }),
          Container(
            height: size.height,
            decoration: BoxDecoration(color: UIColors.black.withOpacity(0.4)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildCountry(
                title: "Choose your country!!!",
                controller: _countryController),
          ),
        ],
      )),
    );
  }

  Widget imageAnimation(dynamic item, Size size) {
    return SizedBox(
      height: size.height,
      child: Image.asset(item, fit: BoxFit.cover),
    );
  }

  Widget _buildCountry(
      {required String title, required TextEditingController controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText(
          text: title,
          style: TextStyle(
              fontSize: 20, color: UIColors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        UnderLineInput(
          hint: "Choose country",
          keyboardType: TextInputType.text,
          isRequired: true,
          enabled: false,
          controller: controller,
          onRightIconPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            showCountryPicker(
              context: context,
              countryListTheme: CountryListThemeData(
                flagSize: 25,
                backgroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                bottomSheetHeight: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              onSelect: (Country country) {
                _countryController.text = country.name;
              },
            );
          },
          iconRight: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: 14,
                color: UIColors.primary,
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        UIButtonWidget(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.toNamed("/home-view",
                  arguments: {"name-country": _countryController.text});
            },
            title: "Choose",
            loading: true,
            enabled: (_countryController.text.isNotEmpty) ? true : false)
      ],
    );
  }
}
