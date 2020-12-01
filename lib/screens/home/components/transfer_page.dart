import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savings/size_config.dart';

// class TransferPage extends StatefulWidget {
//   final user;

//   TransferPage({Key key, @required this.user}) : super(key: key);
//   @override
//   _TransferPageState createState() => _TransferPageState(user);
// }

// class _TransferPageState extends State<TransferPage> with SingleTickerProviderStateMixin {
//   final user;
//   _TransferPageState(this.user);
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   TabBar _getTabBar() {
//     return TabBar(
//       labelColor: Hexcolor("0066F5"),
//       indicatorWeight: 3,
//       indicatorColor: Hexcolor("0066F5"),
//       labelStyle: GoogleFonts.barlow(fontSize: 17,fontWeight: FontWeight.bold),  //For Selected tab
//       unselectedLabelStyle: GoogleFonts.barlow(fontSize: 17,fontWeight: FontWeight.bold), //For Un-selected Tabs
//       tabs: <Widget>[
//         Tab(text: 'Buy'),
//         Tab(text: 'Sell'),
//       ],
//       controller: tabController,
//     );
//   }

//   TabBarView _getTabBarView(tabs) {
//     return TabBarView(
//       children: tabs,
//       controller: tabController,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion(
//         value: SystemUiOverlayStyle(
//           statusBarColor: Hexcolor("0066F5"),
//           statusBarIconBrightness: Brightness.light, //top bar icons
//           systemNavigationBarColor: Colors.white, //bottom bar color
//           systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
//         ), 
//         child: SafeArea(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(top: 35),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 15, top: 5, bottom: 22),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                             SizedBox(
//                               width: 8,
//                             ),
//                             FaDuotoneIcon(FontAwesomeIcons.duotoneCoins, primaryColor: Hexcolor("0066F5"), secondaryColor: Hexcolor("0066F5").withOpacity(.8)),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Buy And Sell",
//                                   style: GoogleFonts.barlow(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                       color: Hexcolor("0066F5")),
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),
//                       Container(
//                         width: 85,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                               Badge(
//                                 badgeContent: Text('3', style: TextStyle(color: Colors.white)),
//                                 child: FaDuotoneIcon(FontAwesomeIcons.duotoneBell, primaryColor: Hexcolor("0066F5"), secondaryColor: Hexcolor("0066F5").withOpacity(.4))
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//                Container(
//                  decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.15),
//                       spreadRadius: .1,
//                       blurRadius: 10,
//                       offset: Offset(0, 20), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: _getTabBar(),
//               ),
//               Expanded(
//                 child: _getTabBarView(
//                   <Widget>[
//                     Container(
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 25, top: 8),
//                         child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 FaDuotoneIcon(FontAwesomeIcons.duotoneShoppingCart, primaryColor: Hexcolor("0066F5").withOpacity(.6), secondaryColor: Hexcolor("0066F5")),
//                                 SizedBox(
//                                   height: 18,
//                                 ),
//                                 Text(
//                                   "Buy with Cash or Card",
//                                   style: GoogleFonts.barlow(
//                                       fontSize: 21,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black),
//                                 ),
//                                 Text(
//                                   "Choose the Crypto you want to buy",
//                                   style: GoogleFonts.barlow(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black),
//                                 ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(

//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math' as math;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);


class TransferPage extends StatefulWidget {
  final user;

  TransferPage({Key key, @required this.user}) : super(key: key);
  @override
  _TransferPageState createState() => _TransferPageState(user);
}

class _TransferPageState extends State<TransferPage> with SingleTickerProviderStateMixin {
  final user;
  _TransferPageState(this.user);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Buy",
    "Sell"
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  // This widget takes the overlapping behavior of the SliverAppBar,
                  // and redirects it to the SliverOverlapInjector below. If it is
                  // missing, then it is possible for the nested "inner" scroll view
                  // below to end up under the SliverAppBar even when the inner
                  // scroll view thinks it has not been scrolled.
                  // This is not necessary if the "headerSliverBuilder" only builds
                  // widgets that do not overlap the next sliver.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      expandedHeight: 130,
                      title: Container(
                          margin: EdgeInsets.only(top: 75, bottom: 25),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      FaDuotoneIcon(FontAwesomeIcons.duotoneCoins, primaryColor: Hexcolor("0066F5"), secondaryColor: Hexcolor("0066F5").withOpacity(.8)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Buy And Sell",
                                            style: GoogleFonts.barlow(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Hexcolor("0066F5")),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                Container(
                                  width: 85,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                        Badge(
                                          badgeContent: Text('3', style: TextStyle(color: Colors.white)),
                                          child: FaDuotoneIcon(FontAwesomeIcons.duotoneBell, primaryColor: Hexcolor("0066F5"), secondaryColor: Hexcolor("0066F5").withOpacity(.4))
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      floating: true,
                      pinned: true,
                      snap: true,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        labelColor: Hexcolor("0066F5"),
                        indicatorWeight: 3,
                        indicatorColor: Hexcolor("0066F5"),
                        labelStyle: GoogleFonts.barlow(fontSize: 17,fontWeight: FontWeight.bold),  //For Selected tab
                        unselectedLabelStyle: GoogleFonts.barlow(fontSize: 17,fontWeight: FontWeight.bold), //For Un-selected Tabs
                        // These are the widgets to put in each tab in the tab bar.
                        tabs: _tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    // This Builder is needed to provide a BuildContext that is "inside"
                    // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                    // find the NestedScrollView.
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber above.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 60.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return Container(
                                      color: Color((math.Random().nextDouble() *
                                                      0xFFFFFF)
                                                  .toInt() <<
                                              0)
                                          .withOpacity(1.0));
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
