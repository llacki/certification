xquery version "1.0-ml";
let $config := 
 <privilege-properties xmlns="http://marklogic.com/manage">
<roles>
<role>security</role>
<role>alert-internal</role>
<role>infostudio-admin-internal</role>
<role>appservices-internal</role>
<role>qconsole-internal</role>
<role>admin-module-internal</role>
<role>flexrep-internal</role>
<role>flexrep-eval</role>
<role>cpf-restart</role>
<role>hadoop-internal</role>
<role>rest-reader-internal</role>
<role>manage-internal</role>
<role>application-plugin-registrar</role>
<role>tiered-storage-internal</role>
<role>view-admin-internal</role>
<role>temporal-internal</role>
<role>temporal-admin</role>
<role>admin-default</role>
<role>redaction-internal</role>
<role>schematron-include-user</role>
<role>manage-schematron-user</role>
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