xquery version "1.0-ml";
let $config := 
 <xdbc-server-properties xmlns="http://marklogic.com/manage">
  <server-name>certification-new-xdbc</server-name>  
  <server-type>xdbc</server-type>
  <root>/</root>
  <port>8005</port>
  <content-database>certification-new</content-database>
  <modules-database>Modules</modules-database>
</xdbc-server-properties>

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

let $response := xdmp:http-post('http://localhost:8002/manage/v2/servers?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $config//*:name || "xdbc created."
else
  $response
;