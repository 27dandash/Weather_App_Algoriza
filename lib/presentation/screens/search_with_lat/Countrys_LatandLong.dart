import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hexcolor/hexcolor.dart';

class Countrys_Lat extends StatelessWidget {
  Countrys_Lat({Key? key}) : super(key: key);

  final List<String> nameofcountry = [
    'Egypt',
    'United Arab Emirates',
    'Saudi Arabia',
    'Syria',
    'Iraq',
    'Jordan',
    'Kuwait',
    'Lebanon',
    'Morocco',
    'Mexico',
    'Austria',
    'Australia',
    'Brazil',
    'Canada',
    'Cuba',
    'Germany',
    'Algeria',
    'Spain',
    'India',
    'Iran',
    'Japan',
    'Afghanistan',
    'Bahrain',
    'Chile',
    'Cameroon',
    'China',
    'Colombia',
    'Costa Rica',
    'Cyprus',
    'Djibouti',
    'Denmark',
    'Dominica',
    'Ecuador',
    'Estonia',
    'Western Sahara',
    'Eritrea',
    'Falkland Islands [Islas Malvinas]',
    'Micronesia',
    'Faroe Islands',
    'Gabon',
    'United Kingdom',
    'Grenada',
    'Georgia',
    'French Guiana',
    'Guernsey',
    'Ghana',
    'Gibraltar',
    'Greenland',
    'Gambia',
    'Guinea',
    'Guadeloupe',
    'Equatorial Guinea',
    'Greece',
    'South Georgia and the South Sandwich Islands',
    'Guatemala',
    'Guam',
    'Guinea-Bissau',
    'Guyana',
    'Gaza Strip',
    'Hong Kong',
    'Heard Island and McDonald Islands',
    'Honduras',
    'Croatia',
    'Haiti',
    'Hungary',
    'Indonesia',
    'Ireland',
    'Isle of Man',
    'British Indian Ocean Territory',
    'Iceland',
    'Italy',
    'Jersey',
    'Jamaica',
    'Kenya',
    'Kyrgyzstan',
    'Cambodia',
    'Kiribati',
    'Comoros',
    'Saint Kitts and Nevis',
    'Kazakhstan',
  ];
  final List<String> lat = [
    '26.820553	',
    '23.424076	',
    '23.885942	',
    '34.802075	',
    '33.223191	',
    '30.585164	',
    '29.31166	',
    '33.854721	',
    '31.791702	',
    '23.634501	',
    '47.516231	',
    '-25.274398',
    '-14.235004',
    '56.130366	',
    '21.521757	',
    '51.165691	',
    '28.033886	',
    '40.463667	',
    '20.593684	',
    '32.427908	',
    '36.204824	',
    '33.93911	',
    '25.930414	',
    '-35.675147',
    '7.369722	',
    '35.86166	',
    '4.570868	',
    '9.748917	',
    '35.126413	',
    '11.825138	',
    '56.26392	',
    '15.414999	',
    '-1.831239	',
    '58.595272	',
    '24.215527	',
    '15.179384	',
    '-51.796253',
    '7.425554	',
    '61.892635	',
    '-0.803689	',
    '55.378051	',
    '12.262776	',
    '42.315407	',
    '3.933889	',
    '49.465691	',
    '7.946527	',
    '36.137741	',
    '71.706936	',
    '13.443182	',
    '9.945587	',
    '16.995971	',
    '1.650801	',
    '39.074208	',
    '-54.429579',
    '15.783471	',
    '13.444304	',
    '11.803749	',
    '4.860416	',
    '31.354676	',
    '22.396428	',
    '-53.08181	',
    '15.199999	',
    '45.1	    ',
    '18.971187	',
    '47.162494	',
    '-0.789275	',
    '53.41291	',
    '54.236107	',
    '-6.343194	',
    '64.963051	',
    '41.87194	',
    '49.214439	',
    '18.109581	',
    '-0.023559	',
    '41.20438	',
    '12.565679	',
    '-3.370417	',
    '-11.875001',
    '17.357822	',
    '48.019573	',
  ];
  final List<String> long = [
    '  30.802498   ',
    '  53.847818   ',
    '	45.079162   ',
    ' 	38.996815   ',
    '  43.679291   ',
    '  36.238414   ',
    '	47.481766   ',
    '	35.862285   ',
    '	-7.09262    ',
    '	-102.552784 ',
    '	14.550072   ',
    '  133.775136  ',
    '	-51.92528   ',
    '	-106.346771 ',
    '	-77.781167  ',
    '	10.451526   ',
    '  1.659626    ',
    '  -3.74922    ',
    '  78.96288    ',
    '  53.688046   ',
    '  138.252924  ',
    '  67.709953   ',
    '	50.637772   ',
    ' 	-71.542969  ',
    '  12.354722   ',
    '  104.195397  ',
    '  -74.297333  ',
    '  -83.753428  ',
    '	33.429859   ',
    '	42.590275   ',
    '  9.501785    ',
    '  -61.370976  ',
    '  -78.183406  ',
    '  25.013607   ',
    '  -12.885834  ',
    '  39.782334   ',
    ' 	-59.523613  ',
    '  150.550812  ',
    '	-6.911806   ',
    '	11.609444   ',
    '	-3.435973   ',
    '	-61.604171  ',
    '	43.356892   ',
    ' -53.125782   ',
    ' -2.585278    ',
    ' -1.023194    ',
    ' -5.345374    ',
    ' -42.604303   ',
    ' -15.310139   ',
    '	-9.696645   ',
    '	-62.067641  ',
    '  10.267895   ',
    '	21.824312   ',
    '	-36.587909  ',
    '  -90.230759  ',
    '	144.793731  ',
    '	-15.180413  ',
    '  -58.93018   ',
    '  34.308825   ',
    '  114.109497  ',
    '  73.504158   ',
    '  -86.241905  ',
    '  15.2	      ',
    '	-72.285215  ',
    '  19.503304   ',
    '  113.921327  ',
    '  -8.24389    ',
    '  -4.548056   ',
    '  71.876519   ',
    '  -19.020835  ',
    '  12.56738    ',
    '  -2.13125    ',
    '  -77.297508  ',
    '  37.906193   ',
    '  74.766098   ',
    '  104.990963  ',
    '  -168.734039 ',
    '  43.872219   ',
    '	-62.782998  ',
    '	66.923684   ',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:HexColor("#83A9E7"),
        title:const Text('Your Country Lat And Long '),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Country',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Tab(
                    child: Text(
                  'Lat',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Lon',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black,
              indicatorWeight: 2.0,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 2),
              labelStyle: TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.white,
            ),
          ),
          body: TabBarView(
              children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: nameofcountry.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              //    color: HexColor(appBarColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nameofcountry[index],
                                //     style: TextStyle(color: HexColor(brownColor)),
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: lat.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              //    color: HexColor(appBarColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                lat[index],
                                //     style: TextStyle(color: HexColor(brownColor)),
                              ),
                            )),
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: lat[index]));
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 19,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: long.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              //    color: HexColor(appBarColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                long[index],
                                //     style: TextStyle(color: HexColor(brownColor)),
                              ),
                            )),
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: long[index]));
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 19,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

// Widget Countrys() => Column(
//       children: [],
//     );
}
