import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CeHttpClient {
  //
  static const token =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc3VhcmlvIjp7ImlkIjoiNjQ4Y2MwNTBjYTZlYjA4NWNhOWU2ZDAzIiwiY2VkdWxhIjoiMDAwMDAwMDUiLCJub21icmUiOiJJbmVhIiwidXN1YXJpbyI6ImluZWEiLCJjb3JyZW8iOiIiLCJmZWNoYWNyZWFjaW9uIjoiMDAwMS0wMS0wMVQwMDowMDowMFoiLCJlc3RhdHVzIjowLCJ0b2tlbiI6IkF1dG9yaXphZG8iLCJQZXJmaWwiOnsiZGVzY3JpcGNpb24iOiJBbmFsaXN0YSJ9LCJGaXJtYURpZ2l0YWwiOnsiZGlyZWNjaW9ubWFjIjoiKiIsImRpcmVjY2lvbmlwIjoiKiIsInRpZW1wbyI6IjIwMjItMDQtMDNUMTk6MDc6MDUuODUxWiJ9LCJBcGxpY2FjaW9uIjpbeyJpZCI6IklELTAwNSIsIm5vbWJyZSI6Ikdlc3Rpb24gZGUgRG9jdW1lbnRvcyIsInVybCI6Imh0dHA6Ly9sb2NhbGhvc3QvYXBwL2dkb2MvaW5kZXguaHRtbD90az0kMCIsIm9yaWdlbiI6IiIsImNvbWVudGFyaW8iOiJVc3VhcmlvIEFsbWFjZW4iLCJ2ZXJzaW9uIjoiVjEuMC4wLjAiLCJhdXRvciI6IkNvZGUtRXBpYyBUZWNobm9sb2dpZXMiLCJSb2wiOnsiaWQiOiIiLCJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IiIsIk1lbnUiOlt7InVybCI6Ii9wcmluY2lwYWwiLCJpY29ubyI6Im5pLXR2LTIiLCJub21icmUiOiJQcmluY2lwYWwiLCJkZXNjcmlwY2lvbiI6IlByaW5jaXBhbCIsImFjY2lvbiI6IlByaW5jaXBhbCgpIiwiY2xhc2UiOiJ0ZXh0LXBpbmsifSx7InVybCI6Ii9zZXJ2aWNpb3MiLCJpY29ubyI6Im5pLWJ1aWxkaW5nIiwibm9tYnJlIjoiU2VydmljaW9zIiwiZGVzY3JpcGNpb24iOiJTZXJ2aWNpb3MiLCJjbGFzZSI6InRleHQtYmx1ZSIsIlN1Yk1lbnUiOlt7InVybCI6Ii9waWxvdGFqZSIsImljb25vIjoicGlsb3RhamUiLCJub21icmUiOiJQaWxvdGFqZSIsImRlc2NyaXBjaW9uIjoiUGlsb3RhamUiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAncmVnaXN0cmFyJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ncmVlbiIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlJlZ2lzdHJhZG9zIiwiYWNjaW9uIjoiUmVnaXN0cmFkb3MoKSIsImRpcmVjdGl2YSI6IiJ9XX0seyJ1cmwiOiIvbGFuY2hhamUiLCJpY29ubyI6ImxhbmNoYWplIiwibm9tYnJlIjoiTGFuY2hhamUiLCJkZXNjcmlwY2lvbiI6IkxhbmNoYWplIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ2J1em9uJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ibHVlIn0seyJ1cmwiOiIvcmVtb2xjYWRvcmVzIiwiaWNvbm8iOiJyZW1vbGNhZG9yZXMiLCJub21icmUiOiJSZW1vbGNhZG9yZXMiLCJkZXNjcmlwY2lvbiI6IlJlbW9sY2Fkb3JlcyIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdwZW5kaWVudGVzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctcHVycGxlIn0seyJ1cmwiOiIvY2FwaXRhbmlhcyIsImljb25vIjoiY2FwaXRhbmlhcyIsIm5vbWJyZSI6IkNhcGl0YW5pYXMgZGUgUHVlcnRvIiwiZGVzY3JpcGNpb24iOiJDYXBpdGFuaWFzIGRlIFB1ZXJ0byIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdwZW5kaWVudGVzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctcHVycGxlIn0seyJ1cmwiOiIvY2VuYXZlIiwiaWNvbm8iOiJjZW5hdmUiLCJub21icmUiOiJDRU5BVkUiLCJkZXNjcmlwY2lvbiI6IkNFTkFWRSIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdwZW5kaWVudGVzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctcHVycGxlIn1dfSx7InVybCI6Ii90cmFtaXRlcyIsImljb25vIjoibmktZGVsaXZlcnktZmFzdCIsIm5vbWJyZSI6IlRyYW1pdGVzIiwiZGVzY3JpcGNpb24iOiJUcmFtaXRlcyIsImNsYXNlIjoidGV4dC1ncmVlbiIsIlN1Yk1lbnUiOlt7InVybCI6Ii9nZW50ZSIsImljb25vIjoiZ2VudGUiLCJub21icmUiOiJHZW50ZSBkZSBNYXIiLCJkZXNjcmlwY2lvbiI6IkdlbnRlIGRlIE1hciIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdyZWdpc3RyYXInKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWdyZWVuIn0seyJ1cmwiOiIvZW1wcmVzYXMiLCJpY29ubyI6ImVtcHJlc2FzIiwibm9tYnJlIjoiRW1wcmVzYXMiLCJkZXNjcmlwY2lvbiI6IkVtcHJlc2FzIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ2J1em9uJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ibHVlIn0seyJ1cmwiOiIvcmVuYXZlIiwiaWNvbm8iOiJyZW5hdmUiLCJub21icmUiOiJSZW5hdmUiLCJkZXNjcmlwY2lvbiI6IlJlbmF2ZSIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdzYWxpZGFzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1waW5rIn0seyJ1cmwiOiIvaW5kdXN0cmlhIiwiaWNvbm8iOiJpbmR1c3RyaWEiLCJub21icmUiOiJJbmR1c3RyaWEgTmF2YWwiLCJkZXNjcmlwY2lvbiI6IkluZHVzdHJpYSBOYXZhbCIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdwZW5kaWVudGVzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctcHVycGxlIn0seyJ1cmwiOiIvc2VndXJpZGFkIiwiaWNvbm8iOiJzZWd1cmlkYWQiLCJub21icmUiOiJTZWd1cmlkYWQiLCJkZXNjcmlwY2lvbiI6IlNlZ3VyaWRhZCBNYXJpdGltYSIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdwZW5kaWVudGVzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctcHVycGxlIn0seyJ1cmwiOiIvcHVlcnRvcyIsImljb25vIjoicHVlcnRvcyIsIm5vbWJyZSI6IlB1ZXJ0b3MiLCJkZXNjcmlwY2lvbiI6IlB1ZXJ0b3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAncGVuZGllbnRlcycpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLXB1cnBsZSJ9LHsidXJsIjoiL2NlcnRpZmljYWNpb24iLCJpY29ubyI6ImNlcnRpZmljYWNpb24iLCJub21icmUiOiJDZXJ0aWZpY2FjaW9uIiwiZGVzY3JpcGNpb24iOiJDZXJ0aWZpY2FjaW9uIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ3BlbmRpZW50ZXMnKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1wdXJwbGUifV19LHsidXJsIjoiL3RlY25vbG9naWEiLCJpY29ubyI6Im5pLWNhcnQiLCJub21icmUiOiJUZWNub2xvZ2lhIiwiZGVzY3JpcGNpb24iOiJPZmljaW5hIGRlIFRlY25vbG9naWEiLCJjbGFzZSI6InRleHQtYmx1ZSIsIlN1Yk1lbnUiOlt7InVybCI6Ii9jYnV6b24iLCJpY29ubyI6ImZhIGZhLXBsdXMtY2lyY2xlIiwibm9tYnJlIjoiU29saWNpdHVkZXMiLCJkZXNjcmlwY2lvbiI6IlNvbGljaXR1ZGVzIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ3JlZ2lzdHJhcicpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLWMtZ3JlZW4ifV19LHsidXJsIjoiL2F0ZW5jaW9uIiwiaWNvbm8iOiJuaS1jYXJ0Iiwibm9tYnJlIjoiQXRlbmNpb24gYWwgY2l1ZGFkYW5vIiwiZGVzY3JpcGNpb24iOiJBdGVuY2lvbiBhbCBjaXVkYWRhbm8iLCJjbGFzZSI6InRleHQtcmVkIiwiU3ViTWVudSI6W3sidXJsIjoiL2NidXpvbiIsImljb25vIjoiZmEgZmEtcGx1cy1jaXJjbGUiLCJub21icmUiOiJTb2xpY2l0dWRlcyIsImRlc2NyaXBjaW9uIjoiU29saWNpdHVkZXMiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAncmVnaXN0cmFyJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ncmVlbiJ9XX0seyJ1cmwiOiIvc2FyIiwiaWNvbm8iOiJuaS1jYXJ0Iiwibm9tYnJlIjoiRW1lcmdlbmNpYXMiLCJkZXNjcmlwY2lvbiI6IkVtZXJnZW5jaWFzIEVtYmFyY2FjaW9uZXMiLCJjbGFzZSI6InRleHQtYmx1ZSIsIlN1Yk1lbnUiOlt7InVybCI6Ii9jYnV6b24iLCJpY29ubyI6ImZhIGZhLXBsdXMtY2lyY2xlIiwibm9tYnJlIjoiU29saWNpdHVkZXMiLCJkZXNjcmlwY2lvbiI6IlNvbGljaXR1ZGVzIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ3JlZ2lzdHJhcicpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLWMtZ3JlZW4ifV19LHsidXJsIjoiL3JlcG9ydGVzIiwiaWNvbm8iOiJuaS1jYXJ0Iiwibm9tYnJlIjoiUmVwb3J0ZXMiLCJkZXNjcmlwY2lvbiI6IlJlcG9ydGVzIiwiY2xhc2UiOiJ0ZXh0LW9yYW5nZSIsIlN1Yk1lbnUiOlt7InVybCI6Ii9yZWdpc3RyYXIiLCJpY29ubyI6ImZhIGZhLXBsdXMtY2lyY2xlIiwibm9tYnJlIjoiUmVnaXN0cmFkb3MiLCJkZXNjcmlwY2lvbiI6IkRvY3VtZW50b3MgUmVnaXN0cmFkb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAncmVnaXN0cmFyJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ncmVlbiJ9LHsidXJsIjoiL2J1em9uIiwiaWNvbm8iOiJmYSBmYS1pbmJveCIsIm5vbWJyZSI6IlJlY2liaWRvcyIsImRlc2NyaXBjaW9uIjoiRG9jdW1lbnRvcyBSZWNpYmlkb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAnYnV6b24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWJsdWUifSx7InVybCI6Ii9zYWxpZGFzIiwiaWNvbm8iOiJmYSBmYS1zaGFyZSIsIm5vbWJyZSI6IlNhbGlkYXMiLCJkZXNjcmlwY2lvbiI6IlNhbGlkYXMgUmVhbGl6YWRhcyIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdzYWxpZGFzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1waW5rIn0seyJ1cmwiOiIvY29uZmlndXJhY2lvbiIsImljb25vIjoiZmEgZmEtZW52ZWxvcGUtb3BlbiIsIm5vbWJyZSI6IlNlZ3VpbWllbnRvIiwiZGVzY3JpcGNpb24iOiIgU2VndWltaWVudG8iLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAnQ29uZmlndXJhY2lvbicpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLXB1cnBsZSJ9XX1dfX1dfSwiZXhwIjoxNjk0NjM4MzA4LCJpc3MiOiJDb2RlIEVwaWMgVGVjaG5vbG9naWVzICJ9.UT3qg18Kj62QSvHaGlT0mC2HhChO4eLtSpZPtrEt5ynj3qCCNUTyv9GnNLGB4ltQk6uXPzuq5mV4bNMwGU6be7Onx1sm1HC03qVJSg7YNo2pnu0hSDsxX5sNhyTUrbIHOSLP156foUxnFcmF7iQPX8Q1eAw1SdBxkgEzgxY1G27HId7HqDBwRrAZlwzP_cSPPrH2TPMe7Z-LqjLcmm1P63MxIH2DwqfWrmC8E1KelbZT56tLc7a0gWI-lWeaLgVEdnnpUJHaP_F27ufXj8Wpjh62dbrAIhLvorsgCbw9XXkJsYc329oJIp-CtXhs8phjxFGxQYAWDiLLthmDSnmwpuKqbEOcixl2dvCOvAQMIHkZtOWT2v4znKdWRBl9WKdGriTwd5PaZzeltBicajO2iZXNHAjbcPdDYJIUhGQNuHQ-TTG8kV0WboxtyfLVWAUP6bu9Z8a8HGbjlhGFCAIMs5F_ftfmtAeJKiCVv63fhFgNDWudxsY_JQIIhGN9APPKHszHfH6CEn4mQdPSMdBxw53TWHVoNeWgkrhR_8oAyt8Hez49DLhsvWFGjnygV8eZatrbZYHx3eK2I7IOLTmTfGmA9u18c1s9GS_UA1qfREEN_nxfAC-KDBo2suVKF1NFr2AY9bXjEp7H8-fSvTOXsc7pD5XpR56RalUQbLh9spc";

  static void configureDio() {
    // dio.options.baseUrl = "http://localhost";
    // dio.options.headers = {
    //   HttpHeaders.contentTypeHeader: "application/json",
    //   HttpHeaders.authorizationHeader: "Bearer " + token,
    // };
  }

  static Future xGET(String path) async {
    // try {
    //   final resp = await dio.get(
    //     path,
    //   );
    //   return resp.data;
    // } catch (e) {
    //   print(e);
    //   throw ('Error de conexion');
    // }
  }

  static Future xPOST(String path, Map<String, dynamic> xdata) async {
    try {
      final response = await http.post(
        // Uri.parse('https://localhost$path'),
        Uri.parse('https://code-epic.com$path'),
        headers: {
          'Content-type': 'application/json',
          'charset': 'UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        encoding: Encoding.getByName("UTF-8"),
        body: jsonEncode(xdata),
      );
      String stringResponse =
          const Utf8Decoder().convert(response.body.codeUnits);
      // print(stringResponse);
      return stringResponse;
      // return response.body;
    } finally {}
  }
}
