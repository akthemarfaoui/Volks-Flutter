import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String PORT = "3003";
const String DOMAIN = "192.168.1.7";
const String URL = "http://$DOMAIN:$PORT";

String getServerURL(String route,[dynamic data])
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


  return URL+route;
}


DateTime getFormatedDate(DateTime dateTime)
{
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateTime);
  return DateTime.parse(formatted);
}


FadeInImage getProfileImage(String username)
{
  var url = getServerURL("/uploads/profileimage/",[username]);
  return FadeInImage.assetNetwork(

    placeholder: 'assets/images/loading_default.gif',
    image: url,
    fit: BoxFit.cover,

  );

}


NetworkImage  getPostProfileImage(String username)
{
  var url = getServerURL("/uploads/profileimage/",[username]);
  return NetworkImage(url);

}






