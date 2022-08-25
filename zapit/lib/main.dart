
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:zapit/details.dart';

import 'apis/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: ' Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  var res;
  Future userid() async {
    //  profil = await getdetails(tokenProfile?.token);
    res = await getdummy();
    print('${res}');
    // print('userId${profil['_id']}');
    return res;
  }

  bool net = false;
  nety() async {
    net = await InternetConnectionChecker().hasConnection;
    setState(() {
      print('nett$net');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nety();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;

    return net == false
        ? Scaffold(
            body: Center(
            child: Text('Check Internet Connection'),
          ))
        : FutureBuilder(
            future: userid(),
            builder: (context, snapShot) {
              //   print("111${ res[0]['logo_url'].toString().contains('svg')}");
              return snapShot.data == Null
                  ? CircularProgressIndicator()
                  : Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.purple[300],
                       
                        title: Text(
                          'Zapit',
                          style: TextStyle(
                              fontSize: 30 * _widthScale,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      body: res == Null
                          ? CircularProgressIndicator()
                          : Container(
                              height: 810 * _heightScale,
                              width: 370 * _widthScale,
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200 * _widthScale,
                                          childAspectRatio: 2.5 / 2,
                                          crossAxisSpacing: 15 * _widthScale,
                                          mainAxisSpacing: 20 * _widthScale),
                                  itemCount:
                                      res.length == Null ? 0 : res.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        net == false
                                            ? Scaffold(
                                                body: Center(
                                                child: InkWell(
                                                    onTap: () async {
                                                      await nety();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                        'Check Internet Connection')),
                                              ))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                  
                                                        DetailsScreen(
                                                          index: index,
                                                        
                                                        )));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            res[index]['logo_url']
                                                    .toString()
                                                    .contains('svg')
                                                ? SvgPicture.network(
                                                    res[index]['logo_url'] == Null ? '' : res[index]['logo_url'] ,
                                                    height: 80 * _heightScale,
                                                    width: 80 * _widthScale,
                                                  )
                                                : Image.network(
                                                     res[index]['logo_url'] == Null ? '' : res[index]['logo_url'] ,
                                                    width: 80 * _widthScale,
                                                    height: 80 * _heightScale,
                                                  ),
                                            SizedBox(
                                              height: 10 * _heightScale,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.purple[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 40 * _heightScale,
                                              width: 155 * _widthScale,
                                              child: Text(
                                                res[index]["name"].toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _widthScale * 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    );
            });
  }
}
