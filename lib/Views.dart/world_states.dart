import 'package:covid19app/Model/world._states.dart';
import 'package:covid19app/Services/state_services.dart';
import 'package:covid19app/Views.dart/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pie_chart/pie_chart.dart';

import '../widget/Widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatete extends StatefulWidget {
  const WorldStatete({Key? key}) : super(key: key);

  @override
  State<WorldStatete> createState() => _WorldStateteState();
}

class _WorldStateteState extends State<WorldStatete>
    with TickerProviderStateMixin {
  late final AnimationController _Controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _Controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          FutureBuilder(
              future: fetchApi(),
              builder: (context, AsyncSnapshot<WorldModelsState> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      controller: _Controller,
                      size: 50.0,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.height * 3 / 2,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        chartType: ChartType.ring,
                        animationDuration: const Duration(milliseconds: 1200),
                        colorList: colorList,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                              ReusableRow(
                                  title: 'Today Cases',
                                  value: snapshot.data!.todayCases.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountriesList()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff1aa260)),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              })
        ]),
      ),
    ));
  }
}
