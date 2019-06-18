// import 'package:scheduler/Tools/Storage.dart';

// class GetSchedule {
//   Future<void> refresh() async {
//     print("Refreshing");
//     if (!(await _handleSignIn())) {
//       print("Not Logged In");

//       setState(() {
//         isLoading = false;
//         isSignedIn = false;
//       });
//       return;
//     }

//     final token = this.googleAccount.idToken;
//     final grade = await Storage.read("grade");

//     if (grade == null) {
//       setState(() {
//         isLoading = false;
//         isSignedIn = false;
//       });
//       return;
//     }

//     if (Constants.debug == false) {
//       final jsonData = await http.get(
//           Constants.endpoint + "?code=$token&grade=$grade&request=schedule");
//       data = json.decode(jsonData.body);
//     } else {
//       final jsonData = await rootBundle.loadString("assets/example.json");
//       data = json.decode(jsonData);
//     }

//     if (data["failed"] != null) {
//       setState(() {
//         this.isLoading = false;
//       });
//     }

//     setState(() {
//       this.isLoading = false;
//       this.isSignedIn = true;
//     });
//   }

// }