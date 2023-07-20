import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CeHttpClient {
  //
  static const token =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc3VhcmlvIjp7ImlkIjoiNjJlYmQwN2U2NmRhMWQ5Nzc0ZTYzODY2IiwiY2VkdWxhIjoiMDAwMDAwMDAiLCJub21icmUiOiJBZG1pbmlzdHJhZG9yIiwidXN1YXJpbyI6ImMwcjMiLCJjb3JyZW8iOiIiLCJmZWNoYWNyZWFjaW9uIjoiMDAwMS0wMS0wMVQwMDowMDowMFoiLCJlc3RhdHVzIjowLCJ0b2tlbiI6IkF1dG9yaXphZG8iLCJQZXJmaWwiOnsiZGVzY3JpcGNpb24iOiJBbmFsaXN0YSBDb250cm9sIn0sIkZpcm1hRGlnaXRhbCI6eyJkaXJlY2Npb25tYWMiOiIqIiwiZGlyZWNjaW9uaXAiOiIqIiwidGllbXBvIjoiMjAyMi0wNC0wM1QxOTowNzowNS44NTFaIn0sIkFwbGljYWNpb24iOlt7ImlkIjoiSUQtMDAxIiwibm9tYnJlIjoiR2VzdGlvbiBkZSBEb2N1bWVudG9zIiwidXJsIjoiaHR0cDovL2xvY2FsaG9zdC9hcHAvZ2RvYy9pbmRleC5odG1sP3RrPSQwIiwib3JpZ2VuIjoiIiwiY29tZW50YXJpbyI6IlVzdWFyaW8gR0RvYyIsInZlcnNpb24iOiJWMS4wLjAuMCIsImF1dG9yIjoiQ29kZS1FcGljIFRlY2hub2xvZ2llcyIsIlJvbCI6eyJpZCI6IiIsIm5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiIiwiTWVudSI6W3sidXJsIjoiL3ByaW5jaXBhbCIsImljb25vIjoibmktdHYtMiIsIm5vbWJyZSI6IlByaW5jaXBhbCIsImRlc2NyaXBjaW9uIjoiUHJpbmNpcGFsIiwiY2xhc2UiOiJ0ZXh0LXByaW1hcnkiLCJTdWJNZW51IjpbeyJpY29ubyI6ImZhIGZhLXBsdXMtY2lyY2xlIiwibm9tYnJlIjoiUmVnaXN0cmFkb3MiLCJkZXNjcmlwY2lvbiI6IkRvY3VtZW50b3MgUmVnaXN0cmFkb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAncmVnaXN0cmFyJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1ncmVlbiJ9LHsiaWNvbm8iOiJmYSBmYS1pbmJveCIsIm5vbWJyZSI6IlJlY2liaWRvcyIsImRlc2NyaXBjaW9uIjoiRG9jdW1lbnRvcyBSZWNpYmlkb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAnYnV6b24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWJsdWUifSx7Imljb25vIjoiZmEgZmEtc2hhcmUiLCJub21icmUiOiJTYWxpZGFzIiwiZGVzY3JpcGNpb24iOiJTYWxpZGFzIFJlYWxpemFkYXMiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAnc2FsaWRhcycpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLWMtcGluayIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlJlZ2lzdHJhZG9zIiwiYWNjaW9uIjoiUmVnaXN0cmFkb3MoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJDbGFzaWZpY2FjaW9uIiwiYWNjaW9uIjoiQ2xhc2lmaWNhY2lvbigpIiwiZGlyZWN0aXZhIjoiIn1dfV19LHsidXJsIjoiL2NvbnRyb2wiLCJpY29ubyI6Im5pLXBsYW5ldCIsIm5vbWJyZSI6IkNvbnRyb2wgeSBHZXN0aW9uIiwiZGVzY3JpcGNpb24iOiJDb250cm9sIHkgR2VzdGlvbiIsImNsYXNlIjoidGV4dC1ibHVlIiwiU3ViTWVudSI6W3sidXJsIjoiL3JlZ2lzdHJhciIsImljb25vIjoiZmEgZmEtcGx1cy1jaXJjbGUiLCJub21icmUiOiJSZWdpc3RyYWRvcyIsImRlc2NyaXBjaW9uIjoiRG9jdW1lbnRvcyBSZWdpc3RyYWRvcyIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdyZWdpc3RyYXInKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWdyZWVuIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVnaXN0cmFkb3MiLCJhY2Npb24iOiJSZWdpc3RyYWRvcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkNsYXNpZmljYWNpb24iLCJhY2Npb24iOiJDbGFzaWZpY2FjaW9uKCkiLCJkaXJlY3RpdmEiOiIifV19LHsidXJsIjoiL2J1em9uIiwiaWNvbm8iOiJmYSBmYS1pbmJveCIsIm5vbWJyZSI6IlJlY2liaWRvcyIsImRlc2NyaXBjaW9uIjoiRG9jdW1lbnRvcyBSZWNpYmlkb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2NvbnRyb2wnLCAnYnV6b24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWJsdWUiLCJQcml2aWxlZ2lvcyI6W3sibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZWNpYmlkb3MiLCJhY2Npb24iOiJSZWNpYmlkb3MoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJQcm9jZXNhZG9zIiwiYWNjaW9uIjoiUHJvY2VzYWRvcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlBlbmRpZW50ZXMiLCJhY2Npb24iOiJQZW5kaWVudGVzKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQ2VycmFkb3MiLCJhY2Npb24iOiJDZXJyYWRvcygpIiwiZGlyZWN0aXZhIjoiIn1dfSx7InVybCI6Ii9zYWxpZGFzIiwiaWNvbm8iOiJmYSBmYS1zaGFyZSIsIm5vbWJyZSI6IlNhbGlkYXMiLCJkZXNjcmlwY2lvbiI6IlNhbGlkYXMgUmVhbGl6YWRhcyIsImFjY2lvbiI6IkNhcmdhclVybCgnY29udHJvbCcsICdzYWxpZGFzJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoiYmctYy1waW5rIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVnaXN0cmFkb3MiLCJhY2Npb24iOiJSZWdpc3RyYWRvcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkNsYXNpZmljYWNpb24iLCJhY2Npb24iOiJDbGFzaWZpY2FjaW9uKCkiLCJkaXJlY3RpdmEiOiIifV19LHsidXJsIjoiL3BlbmRpZW50ZXMiLCJpY29ubyI6ImZhIGZhLWVudmVsb3BlLW9wZW4iLCJub21icmUiOiJTZWd1aW1pZW50byIsImRlc2NyaXBjaW9uIjoiIFNlZ3VpbWllbnRvIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdjb250cm9sJywgJ3BlbmRpZW50ZXMnKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1wdXJwbGUiLCJQcml2aWxlZ2lvcyI6W3sibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJBbGVydGEiLCJhY2Npb24iOiJBbGVydGEoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJQZW5kaWVudGVzIiwiYWNjaW9uIjoiUGVuZGllbnRlcygpIiwiZGlyZWN0aXZhIjoiIn1dfV19LHsidXJsIjoiL3NlY3JldGFyaWEiLCJpY29ubyI6Im5pLXBpbi0zIiwibm9tYnJlIjoiU2VjcmV0YXJpYSIsImRlc2NyaXBjaW9uIjoiU2VjcmV0YXJpYSIsImNsYXNlIjoidGV4dC1vcmFuZ2UiLCJTdWJNZW51IjpbeyJpY29ubyI6ImZhcyBmYS1zaGlwcGluZy1mYXN0Iiwibm9tYnJlIjoiT2ZpY2luYSBQb3N0YWwiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2N1ZXJwbycsICdpbmMvY25jL3JlZ2lzdHJvJykiLCJjbGFzZSI6Im9wdCIsImNvbG9yIjoiYmctc3VjY2VzcyIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkFjdHVhbGl6YXIiLCJhY2Npb24iOiJBY3R1YWxpemFyT1BUKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVwb3J0ZXMiLCJhY2Npb24iOiJSZXBvcnRlcygpIiwiZGlyZWN0aXZhIjoiIn1dfV19LHsidXJsIjoiL3Jlc29sdWNpb25lcyIsImljb25vIjoibmktc2luZ2xlLTAyICIsIm5vbWJyZSI6IlJlc29sdWNpb25lcyIsImRlc2NyaXBjaW9uIjoiUmVzb2x1Y2lvbmVzIiwiY2xhc2UiOiJ0ZXh0LXllbGxvdyIsIlN1Yk1lbnUiOlt7InVybCI6Ii9yc2J1em9uIiwiaWNvbm8iOiJmYSBmYS1pbmJveCIsIm5vbWJyZSI6IkJ1em9uIiwiZGVzY3JpcGNpb24iOiJCdXpvbiIsImFjY2lvbiI6IkNhcmdhclVybCgncmVzb2x1Y2lvbicsICdidXpvbicpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6InRleHQtZ3JlZW4iLCJQcml2aWxlZ2lvcyI6W3sibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZWdpc3RyYWRvcyIsImFjY2lvbiI6IlJlZ2lzdHJhZG9zKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiRW4gUHJvY2VzbyIsImFjY2lvbiI6ImVuUHJvY2VzbygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlBlbmRpZW50ZXMiLCJhY2Npb24iOiJQZW5kaWVudGVzKCkiLCJkaXJlY3RpdmEiOiIifV19LHsidXJsIjoiL3JzdHJhbnNjcmlwY2lvbiIsImljb25vIjoiZmEgZmEta2V5Ym9hcmQiLCJub21icmUiOiJUcmFuc2NyaXBjaW9uIiwiZGVzY3JpcGNpb24iOiJBbmFsaXNpcyBcdTAwMjYgVHJhbnNjcmlwY2lvbiIsImFjY2lvbiI6IkNhcmdhclVybCgncmVzb2x1Y2lvbicsICd0cmFuc2NyaXBjaW9uJykiLCJjbGFzZSI6ImYtbGVmdCIsImNvbG9yIjoidGV4dC1ibHVlIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVjaWJpZG9zIiwiYWNjaW9uIjoiUmVjaWJpZG9zKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUHJvY2VzYWRvcyIsImFjY2lvbiI6IlByb2Nlc2Fkb3MoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJQZW5kaWVudGVzIiwiYWNjaW9uIjoiUGVuZGllbnRlcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkNlcnJhZG9zIiwiYWNjaW9uIjoiQ2VycmFkb3MoKSIsImRpcmVjdGl2YSI6IiJ9XX0seyJ1cmwiOiIvcnNyZXZpc2lvbiIsImljb25vIjoiZmEgZmEtZXllIiwibm9tYnJlIjoiUmV2aXNpb24iLCJkZXNjcmlwY2lvbiI6IlJldmlzaW9uIERvY3VtZW50b3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ3Jlc29sdWNpb24nLCAncmV2aXNpb24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJ0ZXh0LXllbGxvdyIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlJlZ2lzdHJhZG9zIiwiYWNjaW9uIjoiUmVnaXN0cmFkb3MoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJDbGFzaWZpY2FjaW9uIiwiYWNjaW9uIjoiQ2xhc2lmaWNhY2lvbigpIiwiZGlyZWN0aXZhIjoiIn1dfSx7InVybCI6Ii9yc3Byb2Nlc29zIiwiaWNvbm8iOiJmYSBmYS1mb2xkZXItb3BlbiIsIm5vbWJyZSI6IlByb2Nlc29zIiwiZGVzY3JpcGNpb24iOiJQcm9jZXNvcyIsImFjY2lvbiI6IkNhcmdhclVybCgncmVzb2x1Y2lvbicsICdwcm9jZXNvcycpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6InRleHQtcHVycGxlIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQWxlcnRhIiwiYWNjaW9uIjoiQWxlcnRhKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUGVuZGllbnRlcyIsImFjY2lvbiI6IlBlbmRpZW50ZXMoKSIsImRpcmVjdGl2YSI6IiJ9XX0seyJ1cmwiOiIvcnNjb25maWd1cmFjaW9uIiwiaWNvbm8iOiJmYSBmYS1jb2dzIiwibm9tYnJlIjoiQ29uZmlndXJhY2lvbiIsImRlc2NyaXBjaW9uIjoiQ29uZmlndXJhY2lvbmVzIiwiYWNjaW9uIjoiQ2FyZ2FyVXJsKCdyZXNvbHVjaW9uJywgJ2NvbmZpZ3VyYWNpb24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJ0ZXh0LXBpbmsiLCJQcml2aWxlZ2lvcyI6W3sibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZWdpc3RyYWRvcyIsImFjY2lvbiI6IlJlZ2lzdHJhZG9zKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQ2xhc2lmaWNhY2lvbiIsImFjY2lvbiI6IkNsYXNpZmljYWNpb24oKSIsImRpcmVjdGl2YSI6IiJ9XX1dfSx7InVybCI6Ii9heXVkYW50aWEiLCJpY29ubyI6Im5pLWJ1bGxldC1saXN0LTY3Iiwibm9tYnJlIjoiQXl1ZGFudGlhIiwiZGVzY3JpcGNpb24iOiJBeXVkYW50aWEiLCJjbGFzZSI6InRleHQtcmVkIiwiU3ViTWVudSI6W3sidXJsIjoiL2F5YnV6b24iLCJpY29ubyI6ImZhIGZhLWluYm94Iiwibm9tYnJlIjoiQnV6b24iLCJkZXNjcmlwY2lvbiI6IkJ1esOzbiIsImFjY2lvbiI6IkNhcmdhclVybCgnYXl1ZGFudGlhJywgJ2F5YnV6b24nKSIsImNsYXNlIjoiZi1sZWZ0IiwiY29sb3IiOiJiZy1jLWJsdWUiLCJQcml2aWxlZ2lvcyI6W3sibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZWNpYmlkb3MiLCJhY2Npb24iOiJSZWNpYmlkb3MoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJQcm9jZXNhZG9zIiwiYWNjaW9uIjoiUHJvY2VzYWRvcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlBlbmRpZW50ZXMiLCJhY2Npb24iOiJQZW5kaWVudGVzKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQ2VycmFkb3MiLCJhY2Npb24iOiJDZXJyYWRvcygpIiwiZGlyZWN0aXZhIjoiIn1dfSx7InVybCI6Ii9wcm9jZXNvcyIsImljb25vIjoiZmEgZmEtc2hhcmUiLCJub21icmUiOiJQcm9jZXNvcyIsImRlc2NyaXBjaW9uIjoiUHJvY2Vzb3MiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2F5dWRhbnRpYScsICdwcm9jZXNvcycpIiwiY2xhc2UiOiJmLWxlZnQiLCJjb2xvciI6ImJnLWMtcGluayIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IlByb3llY3RvcyIsImFjY2lvbiI6IlByb3llY3RvcygpIiwiZGlyZWN0aXZhIjoiIn0seyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkNvdGl6YWNpb25lcyIsImFjY2lvbiI6IkNvdGl6YWNpb25lcygpIiwiZGlyZWN0aXZhIjoiIn1dfV19LHsidXJsIjoiL2FjYW1pIiwiaWNvbm8iOiJuaS1jaXJjbGUtMDggIiwibm9tYnJlIjoiQWNhbWkiLCJkZXNjcmlwY2lvbiI6IkFjYW1pIiwiY2xhc2UiOiJ0ZXh0LXBpbmsiLCJTdWJNZW51IjpbeyJpY29ubyI6ImZhcyBmYS1zaGlwcGluZy1mYXN0Iiwibm9tYnJlIjoiT2ZpY2luYSBQb3N0YWwiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2N1ZXJwbycsICdpbmMvY25jL3JlZ2lzdHJvJykiLCJjbGFzZSI6Im9wdCIsImNvbG9yIjoiYmctc3VjY2VzcyIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkFjdHVhbGl6YXIiLCJhY2Npb24iOiJBY3R1YWxpemFyT1BUKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVwb3J0ZXMiLCJhY2Npb24iOiJSZXBvcnRlcygpIiwiZGlyZWN0aXZhIjoiIn1dfV19LHsidXJsIjoiL3RpbW9uZWwiLCJpY29ubyI6Im5pLWtleS0yNSIsIm5vbWJyZSI6IlRpbW9uZWwiLCJkZXNjcmlwY2lvbiI6IlRpbW9uZWwiLCJjbGFzZSI6InRleHQtaW5mbyIsIlN1Yk1lbnUiOlt7Imljb25vIjoiZmFzIGZhLXNoaXBwaW5nLWZhc3QiLCJub21icmUiOiJPZmljaW5hIFBvc3RhbCIsImFjY2lvbiI6IkNhcmdhclVybCgnY3VlcnBvJywgJ2luYy9jbmMvcmVnaXN0cm8nKSIsImNsYXNlIjoib3B0IiwiY29sb3IiOiJiZy1zdWNjZXNzIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQWN0dWFsaXphciIsImFjY2lvbiI6IkFjdHVhbGl6YXJPUFQoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZXBvcnRlcyIsImFjY2lvbiI6IlJlcG9ydGVzKCkiLCJkaXJlY3RpdmEiOiIifV19XX0seyJ1cmwiOiIvcGVyc29uYWwiLCJpY29ubyI6Im5pLWJ1bGxldC1saXN0LTY3Iiwibm9tYnJlIjoiUGVyc29uYWwiLCJkZXNjcmlwY2lvbiI6IlBlcnNvbmFsIiwiY2xhc2UiOiJ0ZXh0LXJlZCIsIlN1Yk1lbnUiOlt7Imljb25vIjoiZmFzIGZhLXNoaXBwaW5nLWZhc3QiLCJub21icmUiOiJPZmljaW5hIFBvc3RhbCIsImFjY2lvbiI6IkNhcmdhclVybCgnY3VlcnBvJywgJ2luYy9jbmMvcmVnaXN0cm8nKSIsImNsYXNlIjoib3B0IiwiY29sb3IiOiJiZy1zdWNjZXNzIiwiUHJpdmlsZWdpb3MiOlt7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiQWN0dWFsaXphciIsImFjY2lvbiI6IkFjdHVhbGl6YXJPUFQoKSIsImRpcmVjdGl2YSI6IiJ9LHsibm9tYnJlIjoiIiwiZGVzY3JpcGNpb24iOiJSZXBvcnRlcyIsImFjY2lvbiI6IlJlcG9ydGVzKCkiLCJkaXJlY3RpdmEiOiIifV19XX0seyJ1cmwiOiIvYXJjaGl2byIsImljb25vIjoibmktYXJjaGl2ZS0yIiwibm9tYnJlIjoiQXJjaGl2byIsImRlc2NyaXBjaW9uIjoiQXJjaGl2byIsImNsYXNlIjoidGV4dC1yZWQiLCJTdWJNZW51IjpbeyJpY29ubyI6ImZhcyBmYS1zaGlwcGluZy1mYXN0Iiwibm9tYnJlIjoiT2ZpY2luYSBQb3N0YWwiLCJhY2Npb24iOiJDYXJnYXJVcmwoJ2N1ZXJwbycsICdpbmMvY25jL3JlZ2lzdHJvJykiLCJjbGFzZSI6Im9wdCIsImNvbG9yIjoiYmctc3VjY2VzcyIsIlByaXZpbGVnaW9zIjpbeyJub21icmUiOiIiLCJkZXNjcmlwY2lvbiI6IkFjdHVhbGl6YXIiLCJhY2Npb24iOiJBY3R1YWxpemFyT1BUKCkiLCJkaXJlY3RpdmEiOiIifSx7Im5vbWJyZSI6IiIsImRlc2NyaXBjaW9uIjoiUmVwb3J0ZXMiLCJhY2Npb24iOiJSZXBvcnRlcygpIiwiZGlyZWN0aXZhIjoiIn1dfV19XX19XX0sImV4cCI6MTY4NDk5NjUzMiwiaXNzIjoiQ29kZSBFcGljIFRlY2hub2xvZ2llcyAifQ.PaDec-4G258JmlEK7XiMDmDvo5oJnCH_9GacwRaclgfDm2G2-Mbr8Vl1JvPy6foC-hcaoqd2Mwf1ELah-2yhwu2Enmkv9BBpYvPaHA9xw003BIfMfrcLebXuFOZOdXtpaU_H_SJyzlTkKQdPKn4QWSnWd2bRxnapo35kecqeHck00HLFagTC3yq6w0bh1aZ_00V1SeXw5X4r3-hqErMvSII949bq809kS9luT-WknEamKahW_OuDf-0fqCALcdD9-YXztVnHsHdsTdxymhIVpmFQvZ1DuG3IvQgRc2irWzQVnU4CadHeeZMy5HvU09-i4xpwNbh44OFp4XhIEPOjkD7rhajfHYsvXox5N0eyN33eREbUiUUa1UT7fNvRwWMSvoQk1W58jxL7TNc-1ASt3Kz-2M36AbwRsW8EYfOd0WcOk_CZBZQpJxnKIfu5NgYbHEZE-MLEW08BbJg3qY59mwqB0WsxP13TVZA7cNhZqAN_nVx0XgCaYRBizS2y12HnKQC0axGH2Qo2molA_ceNtCsHGAH5RQmb6T2Y1tJ8Y2Met-VIS7S-D28L34M1E2RC0mhOlIz2Rhe7jWlr4Mv-HgAZc02UDv-kAUUpCm269KE9CiiUJlTt0jDuTuNHcUI3AJyHPlpS8c9XiKvqKjTvBmGk2Bc5ZFuIK5Y4hkhgm-g";

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

  static Future Makeooo(String path, dynamic xdata) async {
    // final formData = FormData.fromMap(xdata);
    // print(xdata);
    // try {
    //   final resp = await dio.post(path,
    //       data: xdata,
    //       options: Options(
    //           headers: {'Content-type': 'application/json; charset=UTF-8'}));
    //   debugPrint(resp.data);
    //   return resp.data;
    // } catch (e) {
    //   print(e);
    //   throw ('Error de conexion');
    // }
  }

  static Future xPOST(String path, Map<String, dynamic> xdata) async {
    String bearer = 'Bearer ' + token;

    try {
      final response = await http.post(
        Uri.parse('https://code-epic.com$path'),
        headers: {
          'Content-type': 'application/json;charset=utf-8',
          HttpHeaders.authorizationHeader: 'Bearer ' + token,
        },
        encoding: Encoding.getByName("utf-8"),
        body: jsonEncode(xdata),
      );
      // print(response.body);

      return response.body;
    } finally {}
  }
}