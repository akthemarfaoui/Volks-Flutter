import 'dart:convert';

import "package:http/http.dart" as http;

const String PORT = "3003";
const  String DOMAIN = "192.168.1.7";
const String URL = "http://$DOMAIN:$PORT";

String getFormatedRoute(String route,[dynamic data])
{
  String argData = "";
  for(dynamic arg in data)
  {
    if(arg!=null )
    {
      if(arg.toString()!="")
        argData += "/"+ arg.toString();
    }
  }

  route = route + argData;
  route=route.replaceAll('//', '/'); // besh mantihouch fel cas mtaa /users/get//malek

  if(!route.startsWith("/"))        // besh mantihouch fel cas mtaa users/get/malek donc izid just /users/get/malek
      {
    route = "/"+route;
  }
  return route;
}



