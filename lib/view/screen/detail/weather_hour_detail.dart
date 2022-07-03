import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/entity/weather_entity.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/container/asset_image.dart';
import 'package:weather_app/view/container/widget/ui_text.dart';

class WeatherHourDetail extends StatefulWidget {
  const WeatherHourDetail(
      {Key? key, required this.forecastday, required this.index})
      : super(key: key);
  final Forecastday forecastday;
  final int index;

  @override
  State<WeatherHourDetail> createState() => _WeatherHourDetailState();
}

class _WeatherHourDetailState extends State<WeatherHourDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (widget.forecastday.day!.dailyWillItRain == 1)
              Container(
                height: size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsImage.imageTroiMua),
                        fit: BoxFit.cover)),
              ),
            if (widget.forecastday.day!.dailyWillItRain == 0)
              Container(
                height: size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsImage.imageTroiNang),
                        fit: BoxFit.cover)),
              ),
            Container(
              height: size.height,
              decoration: BoxDecoration(color: UIColors.black.withOpacity(0.3)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(widget.forecastday),
                SizedBox(
                  height: size.height * 0.05,
                ),
                _buildBody(widget.forecastday, size),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: UIText(
                    text: "Time to day",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: UIColors.white,
                        fontSize: 24),
                  ),
                ),
                _buildBody2(widget.forecastday, size)
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _currentDateToString(DateTime currentDate) {
    final day = DateFormat.d(Intl.defaultLocale).format(currentDate);
    final monthString = DateFormat.MMM(Intl.defaultLocale).format(currentDate);
    final year = DateFormat.y(Intl.defaultLocale).format(currentDate);
    return "$day $monthString $year";
  }

  Widget _buildHeader(Forecastday forecastday) {
    DateTime dateTime = DateTime.parse(forecastday.date!);
    final formatDay = DateFormat.E(Intl.defaultLocale).format(dateTime);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios, color: UIColors.white),
            onTap: () {
              Get.back();
            },
          ),
          Column(
            children: [
              UIText(
                text: "${forecastday.day!.condition!.text}",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: UIColors.white,
                    fontSize: 24),
              ),
              UIText(
                text: "${formatDay},${_currentDateToString(dateTime)}",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: UIColors.white,
                    fontSize: 12),
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }

  Widget _buildBody(Forecastday forecastday, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _buildBody1(forecastday, size),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAstro(
                title: "Sunrise : ", content: "${forecastday.astro!.sunrise}"),
            _buildTitleAstro(
                title: "Sunset : ", content: "${forecastday.astro!.sunset}"),
            _buildTitleAstro(
                title: "Moonrise : ",
                content: "${forecastday.astro!.moonrise}"),
            _buildTitleAstro(
                title: "Moon Phase : ",
                content: "${forecastday.astro!.moonPhase}"),
            _buildTitleAstro(
                title: "Moon Illumination : ",
                content: "${forecastday.astro!.moonIllumination}%"),
          ],
        )
      ],
    );
  }

  Widget _buildTitleAstro({required String title, required String content}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          UIText(
              text: title,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: UIColors.white,
                  fontSize: 14)),
          UIText(
              text: content,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: UIColors.white,
                  fontSize: 14))
        ],
      ),
    );
  }

  Widget _buildBody1(Forecastday forecastday, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: 'http:${forecastday.day!.condition!.icon!}',
            width: size.width * 0.3,
            fit: BoxFit.contain,
          ),
          UIText(
            text: "${forecastday.day!.avgtempC!.toInt()}ºC",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: UIColors.white,
                fontSize: 48),
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(Forecastday forecastday, Size size) {
    return _buildList(forecastday);
  }

  Widget _buildList(Forecastday forecastday) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: forecastday.hour!.length,
        itemBuilder: (_, index) {
          DateTime dateTime =
              DateTime.parse(forecastday.hour!.elementAt(index).time!);
          String convertedDateTime =
              "${dateTime.hour.toString().padLeft(2, '0')}H${dateTime.minute.toString().padLeft(2, '0')}'";
          return InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: "Time: ${convertedDateTime}",
                  backgroundColor: UIColors.white,
                  onCancel: () {},
                  cancelTextColor: UIColors.black,
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIcon(
                              title:
                                  '${forecastday.hour!.elementAt(index).humidity}%',
                              description: 'Humidity',
                              icon: AssetsImage.iconNuoc),
                          _buildIcon(
                              title:
                                  '${forecastday.hour!.elementAt(index).windKph}Km/h',
                              description: 'Wind',
                              icon: AssetsImage.iconKM),
                          _buildIcon(
                              title:
                                  '${forecastday.hour!.elementAt(index).pressureMb!.toInt()}',
                              description: 'Air Pressure',
                              icon: AssetsImage.iconSpeed),
                          _buildIcon(
                              title:
                                  '${forecastday.hour!.elementAt(index).visKm!.toInt()}Km',
                              description: 'Visibility',
                              icon: AssetsImage.iconEye),
                        ],
                      ),
                    ],
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: UIColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIText(
                    text: 'Time: ${convertedDateTime}',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: UIColors.white,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'http:${forecastday.hour!.elementAt(index).condition!.icon!}',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      UIText(
                        text:
                            "${forecastday.hour!.elementAt(index).tempC!.toInt()}ºC",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: UIColors.white,
                            fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return Divider(
            color: UIColors.description.withOpacity(0.2),
            thickness: 1,
          );
        },
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
}
