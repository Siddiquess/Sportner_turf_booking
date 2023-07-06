// import 'dart:async';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'api_status.dart';
// import 'service_exeptions.dart';

// class ApiServices {
//   static Future<Object> postMethod({
//     required String url,
//     required Map body,
//     Function? jsonDecode,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response =
//           await http.post(Uri.parse(url), body: body, headers: headers);

//       if (response.statusCode == 201 || response.statusCode == 200) {
//         log("Success");
//         return Success(
//             response: jsonDecode == null ? null : jsonDecode(response.body));
//       }
//       return Failure(
//         code: response.statusCode,
//         errorResponse: "Invalid Response",
//       );
//     } on Exception catch (e) {
//       return ServiceExeptions.cases(e);
//     }
//   }

//   static Future<Object> getMethod(
//       {required String url,
//       Function? jsonDecod,
//       Map<String, String>? headers}) async {
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Success(
//           response: jsonDecod == null ? null : jsonDecod(response.body),
//         );
//       }

//       return Failure(
//           code: response.statusCode, errorResponse: "Invalid Response");
//     } on Exception catch (e) {
//       return ServiceExeptions.cases(e);
//     }
//   }
// }
