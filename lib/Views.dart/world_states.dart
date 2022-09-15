import 'package:covid19app/Model/world._states.dart';
import 'package:covid19app/Services/state_services.dart';
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
    StateServices stateServices = StateServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          FutureBuilder(
              future: stateServices.fetchWorldApi(),
              builder: (context, AsyncSnapshot<Worls_State> snapshot) {
                if (snapshot.hasData) {
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
                          "Total": 20,
                          "Recovered": 15,
                          "Deaths": 5,
                        },
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
                              ReusableRow(title: 'Title', value: '200'),
                              ReusableRow(title: 'Title', value: '200'),
                              ReusableRow(title: 'Title', value: '200'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff1aa260)),
                        child: Center(
                          child: Text('Track Countries'),
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
