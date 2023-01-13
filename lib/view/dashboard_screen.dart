import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/sharedPrefernce_controller.dart';
import 'package:weather_app/view/dashbord_widgets/information_tile.dart';
import '../controller/location_provider.dart';
import '../controller/sharedPrefernce_controller.dart';
import '../controller/sharedPrefernce_controller.dart';
import '../controller/weather_funtion.dart';

var items = [
  'Humidity',
  'Wind Speed',
  'FeelsLikeCelsius',
];
String dropdownvalue = 'Humidity';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  WeatherService weatherService = WeatherService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      final locationProvider =
          Provider.of<LocationController>(context, listen: false);

      Provider.of<SharedController>(context, listen: false).getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationController>(context, listen: false);
    final sharedProvider =
        Provider.of<SharedController>(context, listen: false);

    return Stack(
      children: [
        FutureBuilder(
            future: Provider.of<WeatherService>(context, listen: false)
                .getWeatherData(locationProvider.latitude,
                    locationProvider.longtitude, context),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Scaffold(
                      appBar: AppBar(
                        title: DropdownButton(
                          isExpanded: true,
                          // Initial Value
                          value: dropdownvalue,
                          underline: Container(
                            height: 0,
                            color: Colors.deepPurpleAccent,
                          ),
                          // Down Arrow Icon
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              print(dropdownvalue);
                            });
                          },
                        ),
                        backgroundColor: Color(0xff005c97),
                      ),
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: <Color>[
                              Color(0xff005c97),
                              Color(0xff363795)
                            ],
                            stops: <double>[0, 1],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.19, 0, 0, 2.81),
                              width: 28.19,
                              height: 28.19,
                              child: Icon(Icons.location_on,
                                  color: Color(0xffffb200)),
                            ),
                            Center(
                              // londonXxT (7:4)
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  sharedProvider.location,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Cabin',
                                    fontSize: 37,
                                    fontWeight: FontWeight.w700,
                                    height: 1.215,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // group1tRd (7:6)
                              margin: EdgeInsets.fromLTRB(106, 0, 60.5, 0.5),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    // Dyh (7:8)
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        sharedProvider.temperatureCelsius.replaceAll(".0", ""),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Cabin',
                                          fontSize: 90,
                                          fontWeight: FontWeight.w700,
                                          height: 1.215,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    // cvdD (7:7)
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                      child: Text(
                                        'ºC',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Cabin',
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          height: 1.215,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              // cloudy3C3 (7:5)
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 6, 28.5),
                                child: Text(
                                 sharedProvider.weatherCondition,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Cabin',
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    height: 1.215,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 23,),
                            InformationTile()
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator(),);
            }),
      ],
    );
  }
}
