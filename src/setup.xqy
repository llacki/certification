(:

1. Execute the script to create a forest and a database for this unit hands-on. 

For more information about the rest endpoints being used, see following resources:
https://docs.marklogic.com/REST/POST/manage/v2/databases. 
https://docs.marklogic.com/REST/POST/manage/v2/forests.

:)

xquery version "1.0-ml";
let $config := <forest-properties xmlns="http://marklogic.com/manage">
  <forest-name>certification-01</forest-name>
 </forest-properties>

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

let $response := xdmp:http-post('http://localhost:8002/manage/v2/forests?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $config//*:name || "sec-unit-09 forest created."
else
  $response

;

xquery version "1.0-ml";
let $config := <database-properties xmlns="http://marklogic.com/manage">
  <database-name>certification</database-name>
  <forests>
    <forest>certification-01</forest>
  </forests>
  <schema-database>Schemas</schema-database>
</database-properties>

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

let $response := xdmp:http-post('http://localhost:8002/manage/v2/databases?format=xml', $options)
return if ($response//*:code/string() = "201") then
  $config//*:name || "sec-unit-09 database created."
else
  $response