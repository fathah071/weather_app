import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/dashboard_screen.dart';

import '../../controller/sharedPrefernce_controller.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedProvider =
        Provider.of<SharedController>(context, listen: false);
    return Container(
        margin: EdgeInsets.fromLTRB(61, 0, 61, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          color: Color(0xffffb200),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              dropdownvalue.contains("eel")
                  ? "assets/tem_c.png"
                  : dropdownvalue.contains("W")
                  ? "assets/wind.png"
                  : dropdownvalue.contains("mi")
                  ?  "assets/hum.png"
                  : "",
              width: 200,
              height: 100,
            ),
            Text(
              dropdownvalue.contains("eel")
                  ? "${sharedProvider.feelsLikeCelsius}ºC"
                  : dropdownvalue.contains("W")
                      ? "${sharedProvider.windSpeed}/KMH"
                      : dropdownvalue.contains("mi")
                          ? "${sharedProvider.humidity}ºC"
                          : "",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Text(
              dropdownvalue,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color:Colors.white,fontSize: 30),
            )
          ],
        ));
  }
}
