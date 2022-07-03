import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/container/asset_image.dart';
import 'package:weather_app/view/container/widget/ui_text.dart';

class HomeDetailView extends StatefulWidget {
  const HomeDetailView({Key? key}) : super(key: key);

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UIColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(
                height: size.height * 0.05,
              ),
              _buildBody(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                text: "Today's Weather",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: UIColors.white,
                    fontSize: 24),
              ),
              UIText(
                text: "Sunday , 8 March 2022",
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

  Widget _buildBody(Size size) {
    return Container(
      width: size.width * 0.8,
      child: Column(
        children: [
          _buildBody1(size),
          SizedBox(height: size.height * 0.05,),
          _buildBody2(size),
        ],
      ),
    );
  }

  Widget _buildBody1(Size size) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: UIColors.white.withOpacity(0.3), width: 2),
        color: UIColors.white.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AssetsImage.imageMua,
            fit: BoxFit.cover,
            height: size.height * 0.20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIText(
                text: '29º',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: UIColors.white,
                    fontSize: 60),
              ),
              UIText(
                text: '05:00 AM',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: UIColors.white,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody2(Size size) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: UIColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(
            text: 'Future Weather',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: UIColors.black,
                fontSize: 18),
          ),
          SizedBox(height: size.height * 0.02,),
          _buildListWeather(size)
        ],
      ),
    );
  }

  Widget _buildListWeather(Size size) {
    return ListView.separated(
      separatorBuilder: (_ , index) {
        return Divider(color: UIColors.description,);
      },
      shrinkWrap: true,
        itemCount: 4,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return _buildWeatherFuture(size);
        });
  }

  Widget _buildWeatherFuture(Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AssetsImage.imageMua,
            fit: BoxFit.cover,
            height: size.height * 0.1,
          ),
          UIText(
            text: '29º',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: UIColors.black,
                fontSize: 36),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              UIText(
                text: 'MonDay',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: UIColors.black,
                    fontSize: 13),
              ),
              UIText(
                text: '9 March 2021',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: UIColors.textDes,
                    fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}
