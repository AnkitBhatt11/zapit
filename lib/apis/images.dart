
import 'dart:convert';

//import 'package:heybuddy/api/signin_api.dart';
import 'package:http/http.dart' as http;
//import 'package:mybud/widgets/token_profile.dart';

//var tokens = tokenProfile?.token;
Future getdummy() async {
  http.Response res = await http.get(
    Uri.parse(
        'https://api.nomics.com/v1/currencies/ticker?key=00b5331b1516f377db75d808bfbc7df383be129f'),
   // headers: {'Authorization': "Bearer " + token
   // 'eyJhbGciOiJIUzI1NiJ9.IjYxYjVmZTllMDY2ZjNhOWJmYjc0ODFiMiI.1BrDUIYNTertbV74L05Zc-6UC6p0WqLkIXBA1Outxac'
    // token
    // },
  );
   var share1 = json.decode(res.body);
  // var share2 = json.decode(res.body)['message'];
  if (res.statusCode == 200) {
    print("resdata.............${share1[0]["logo_url"]}");
    // print('mmm$share2');
    // print('mopopo$share1');
    // print(res);
     return share1;
  } else if (res.statusCode == 400) {
    print('hjvhjvjh');
    print(res.body);
  } else {
    return 'pp';
  }
  //return {"statusCode": res.statusCode, "response": share1};
}
