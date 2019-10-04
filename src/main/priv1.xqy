xquery version "1.0-ml";

declare namespace p="http://marklogic.com/manage";

let $options2 := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <headers>
     <content-type>application/xml</content-type>
   </headers>
   </options>

let $roles :=  xdmp:http-get("http://localhost:8002/manage/v2/privileges/xdmp:http-get/properties?kind=execute", $options2)[2]/*/p:roles/p:role

let $config := 
 <privilege-properties xmlns="http://marklogic.com/manage">
<roles>
{$roles}
<role>cia</role>
</roles>
</privilege-properties>

let $options := <options xmlns="xdmp:http">
   <authentication method="digest">
     <username>admin</username>
     <password>admin</password>
   </authentication>
   <!-- xdmp.quote() formats the config object as a string so the REST endpoint understands it -->
   <data>{xdmp:quote($config)}</data>
   <headers>
     <content-type>application/xml</content-type>
   </headers>
   </options>

let $response := xdmp:http-put("http://localhost:8002/manage/v2/privileges/xdmp:http-get/properties?kind=execute&amp;format=xml", $options)
return if ($response//*:code/string() = "201") then
  $config//*:name || "Added."
else
  $response
;