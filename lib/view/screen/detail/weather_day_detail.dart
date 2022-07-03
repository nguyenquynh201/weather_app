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

class WeatherDayDetail extends StatefulWidget {
  const WeatherDayDetail({Key? key, required this.current}) : super(key: key);
  final Current current;

  @override
  State<WeatherDayDetail> createState() => _WeatherDayDetailState();
}

class _WeatherDayDetailState extends State<WeatherDayDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: size.height,
              child: Stack(
                children: [
                  if (widget.current.isDay == 1)
                    Container(
                      height: size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsImage.imageNgay),
                              fit: BoxFit.cover)),
                    ),
                  if (widget.current.isDay == 0)
                    Container(
                      height: size.height,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsImage.imageDem),
                              fit: BoxFit.cover)),
                    ),
                  Container(
                    height: size.height,
                    decoration:
                        BoxDecoration(color: UIColors.black.withOpacity(0.3)),
                  ),
                  Column(
                    children: [
                      _buildHeader(widget.current),
                      _buildBody(widget.current, size),
                      _buildBody2(widget.current, size)
                    ],
                  )
                ],
              )),
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

  Widget _buildHeader(Current current) {
    DateTime dateTime = DateTime.parse(current.lastUpdated!);
    final formatDay = DateFormat.E(Intl.defaultLocale).format(dateTime);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                text: "${current.condition!.text}",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: UIColors.white,
                    fontSize: 24),
              ),
              UIText(
                text: "$formatDay,${_currentDateToString(dateTime)}",
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

  Widget _buildBody(Current current, Size size) {
    return Column(
      children: [
        _buildBody1(current, size),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildBody1(Current current, Size size) {
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: 'http:${current.condition!.icon!}',
            fit: BoxFit.contain,
          ),
          UIText(
            text: "${current.tempC!.toInt()}ºC",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: UIColors.white,
                fontSize: 64),
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(Current current, Size size) {
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
        decoration: BoxDecoration(
            color: UIColors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  color: UIColors.black.withOpacity(0.2),
                  blurRadius: 20)
            ]),
        child: Column(
          children: [
            _buildIcon(
                title: '${current.humidity}%',
                description: 'Humidity',
                icon: AssetsImage.iconNuoc),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.windKph}Km/h',
                description: 'Wind',
                icon: AssetsImage.iconKM),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.pressureMb!.toInt()}',
                description: 'Air Pressure',
                icon: AssetsImage.iconSpeed),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.visKm!.toInt()}Km',
                description: 'Visibility',
                icon: AssetsImage.iconEye),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.uv!.toInt()}%',
                description: 'UV',
                icon: AssetsImage.iconUV),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.cloud!.toInt()}%',
                description: 'Cloud',
                icon: AssetsImage.iconCloud),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.precipMm!.toInt()}mm',
                description: 'Rain',
                icon: AssetsImage.iconRain),
            SizedBox(
              width: 12,
            ),
            _buildIcon(
                title: '${current.uv!.toInt()}',
                description: 'FeelLike',
                icon: AssetsImage.iconFeelLike),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildIcon(
      {required String title,
      required String description,
      required String icon}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                width: 32,
                height: 32,
              ),
              UIText(
                text: description,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: UIColors.description,
                    fontSize: 14),
              )
            ],
          ),
          UIText(
            text: title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: UIColors.black,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
