import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/data/entity/weather_entity.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/container/asset_image.dart';
import 'package:weather_app/view/container/widget/ui_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/view/screen/detail/weather_day_detail.dart';
import 'package:weather_app/view/screen/detail/weather_hour_detail.dart';
import 'package:weather_app/view/screen/home/home_detail.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  late TextEditingController _countryController;
  double viewportFraction = 10;
  int _currentPage = 0;
  late Timer _timer;
  bool isLoad = false;
  final WeatherController controller = Get.find();
  List image = [
    AssetsImage.imageTroiMua,
    AssetsImage.imageTroiNang,
    AssetsImage.imageTroiRam
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.5);
    _countryController =
        TextEditingController(text: Get.arguments['name-country']);
    controller.fetchLocation(_countryController.text);
    controller.search.value = _countryController.text;
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
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              PageView.builder(
                  controller: _pageController =
                      PageController(viewportFraction: 1),
                  itemCount: image.length,
                  itemBuilder: (context, index) {
                    return imageAnimation(image.elementAt(index), size);
                  }),
              Container(
                height: size.height,
                decoration:
                    BoxDecoration(color: UIColors.black.withOpacity(0.4)),
              ),
              SingleChildScrollView(
                child: Obx(
                  () {
                    if (controller.isLoad.value == true) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(size, controller.location.value,
                              controller.current.value),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          _buildBody(size, controller.current.value,
                              controller.forecast.value)
                        ],
                      );
                    } else {
                      return _buildLoadPage(size);
                    }
                  },
                ),
              ),
              if (isLoad == true) _buildLoadPage(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadPage(Size size) {
    return Stack(
      children: [
        Container(
          height: size.height,
          decoration: BoxDecoration(color: UIColors.black.withOpacity(0.8)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoad(),
            SizedBox(
              height: 10,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Loading....',
                  textStyle: GoogleFonts.inter(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ],
              stopPauseOnTap: true,
            )
          ],
        )
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Container(),
          InkWell(
              child: Icon(Icons.menu_open, color: UIColors.white),
              onTap: () async {
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
                  onSelect: (Country country) async {
                    setState(() {
                      isLoad = true;
                    });
                    _countryController.text = country.name;
                    controller.fetchLocation(_countryController.text);
                    controller.search.value = country.name;
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      isLoad = false;
                    });
                  },
                );
              })
        ],
      ),
    );
  }

  Widget imageAnimation(dynamic item, Size size) {
    return SizedBox(
      height: size.height,
      child: Image.asset(item, fit: BoxFit.cover),
    );
  }

  Widget _buildLoad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LoadingAnimationWidget.threeArchedCircle(
              color: UIColors.white, size: 30),
        ),
      ],
    );
  }

  Widget _buildBody(Size size, Current current, Forecast forecast) {
    return Column(
      children: [
        _buildBody1(size, current),
        _buildBody2(size, current),
        SizedBox(
          height: size.height * 0.02,
        ),
        _buildFooter(size, forecast)
      ],
    );
  }

  Widget _buildHeader(Size size, Location location, Current current) {
    DateTime dateTime = DateTime.parse(current.lastUpdated!);
    String convertedDateTime =
        "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 12),
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    isLoad = true;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  controller.onRefresh();
                  setState(() {
                    isLoad = false;
                  });
                },
                icon: Icon(
                  Icons.refresh,
                  color: UIColors.white,
                )),
          ),
          Column(
            children: [
              UIText(
                text: '${location.name}',
                style: GoogleFonts.inter(
                    color: UIColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              UIText(
                text: '$convertedDateTime',
                style: GoogleFonts.inter(
                    color: UIColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          _buildAppBar()
        ],
      ),
    );
  }

  Widget _buildBody1(Size size, Current current) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoad = true;
        });
        await Future.delayed(const Duration(seconds: 2),
            () => Get.to(() => WeatherDayDetail(current: current)));
        setState(() {
          isLoad = false;
        });
      },
      child: Container(
          height: size.height * 0.35,
          width: size.width * 0.9,
          alignment: Alignment.center,
          child: _buildItemPage(size, current)),
    );
  }

  String _currentDateToString(DateTime currentDate) {
    final day = DateFormat.d(Intl.defaultLocale).format(currentDate);
    final monthString = DateFormat.MMM(Intl.defaultLocale).format(currentDate);
    final year = DateFormat.y(Intl.defaultLocale).format(currentDate);
    return "$day $monthString $year";
  }

  Widget _buildItemPage(Size size, Current current) {
    DateTime dateTime = DateTime.parse(current.lastUpdated!);
    final formatDay = DateFormat.E(Intl.defaultLocale).format(dateTime);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(
            text: 'To day',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: UIColors.white,
                fontSize: 16),
          ),
          SizedBox(height: 10,),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: size.height * 0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    UIColors.primary.withOpacity(0.1),
                    UIColors.description.withOpacity(0.1)
                  ], begin: Alignment.bottomRight, end: Alignment.topRight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'http:${current.condition!.icon!}',
                      width: size.width * 0.25,
                      height: size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UIText(
                          text: "${current.tempC!.toInt()}ºC",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: UIColors.white,
                              fontSize: 32),
                        ),
                      ],
                    ),
                    UIText(
                      text: "${current.condition!.text}",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: UIColors.white,
                          fontSize: 10),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 1,
                left: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: UIColors.white),
                    child: UIText(
                      text: "$formatDay,${_currentDateToString(dateTime)}",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: UIColors.black,
                          fontSize: 10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(Size size, Current current) {
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                color: UIColors.black.withOpacity(0.2),
                blurRadius: 20)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIcon(
                  title: '${current.humidity}%',
                  description: 'Humidity',
                  icon: AssetsImage.iconNuoc),
              _buildIcon(
                  title: '${current.windKph}Km/h',
                  description: 'Wind',
                  icon: AssetsImage.iconKM),
              _buildIcon(
                  title: '${current.pressureMb!.toInt()}',
                  description: 'Air Pressure',
                  icon: AssetsImage.iconSpeed),
              _buildIcon(
                  title: '${current.visKm!.toInt()}Km',
                  description: 'Visibility',
                  icon: AssetsImage.iconEye),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(
      {required String title,
      required String description,
      required String icon}) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
        UIText(
          text: title,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: UIColors.black, fontSize: 12),
        ),
        UIText(
          text: description,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: UIColors.description,
              fontSize: 10),
        )
      ],
    );
  }

  Widget _buildFooter(Size size, Forecast forecast) {
    return Column(
      children: [
        _buildTextToday(size),
        SizedBox(
          height: size.width * 0.03,
        ),
        _buildListWeather(size, forecast.forecastday!)
      ],
    );
  }

  Widget _buildTextToday(Size size) {
    return SizedBox(
      width: size.width * 0.8,
      child: UIText(
        text: 'Weather In Day',
        style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: UIColors.white,
            fontSize: 16),
      ),
    );
  }

  Widget _buildListWeather(Size size, List<Forecastday> forecastList) {
    return SizedBox(
      height: size.height * 0.2,
      child: ListView.builder(
          itemCount: forecastList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return WeatherItemWidget(
              size: size,
              forecastday: forecastList.elementAt(index),
              onPressed: () async {
                setState(() {
                  isLoad = true;
                });
                await Future.delayed(
                    const Duration(seconds: 2),
                    () => Get.to(() => WeatherHourDetail(
                          forecastday: forecastList[index],
                          index: index,
                        )));
                setState(() {
                  isLoad = false;
                });
              },
            );
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _pageController.dispose();
  }
}

class WeatherItemWidget extends StatefulWidget {
  const WeatherItemWidget(
      {Key? key, required this.size, required this.forecastday, this.onPressed})
      : super(key: key);
  final Size size;
  final Forecastday forecastday;
  final VoidCallback? onPressed;

  @override
  State<WeatherItemWidget> createState() => _WeatherItemWidgetState();
}

class _WeatherItemWidgetState extends State<WeatherItemWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.forecastday.date!);
    String convertedDateTime =
        "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}";

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: widget.size.width * 0.2,
        height: widget.size.height * 0.1,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: UIColors.primary.withOpacity(0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UIText(
              text: convertedDateTime,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: UIColors.white,
                  fontSize: 12),
            ),
            CachedNetworkImage(
              imageUrl: 'http:${widget.forecastday.day!.condition!.icon!}',
              width: widget.size.width * 0.15,
              height: widget.size.height * 0.10,
              fit: BoxFit.cover,
            ),
            UIText(
              text: '${widget.forecastday.day!.avgtempC}ºC',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: UIColors.white,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
