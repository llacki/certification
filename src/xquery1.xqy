xquery version "1.0-ml";

declare namespace cert = "http://certification";
 
 declare function cert:month-name-to-int
  ( $stringIN as xs:string? )  as xs:string? {
   switch (fn:lower-case($stringIN))
   case "january" return "01"
   case "february" return "02"
   case "march" return "03"
   case "april" return "04"
   case "may" return "05"
   case "june" return "06"
   case "july" return "07"
   case "august" return "08"
   case "september" return "09"
   case "october" return "10"
   case "november" return "11"
   case "december" return "12"
   default return fn:error(xs:QName("ERROR"), "unknown month")
 };
 
 declare function cert:parse-date($date){
 let $split :=tokenize($date, " ")
let $month := cert:month-name-to-int($split[1])

let $normalized-date := replace($date, $split[1], $month)

let $day := $split[2]
return   xdmp:parse-dateTime("[M01] [D01], [Y0001]",
		   $normalized-date)  cast as xs:date 
 };

let $date-range-from := "January 01, 2010"
let $date-range-to := "December 31, 2015"
let $city := "Columbus"
let $state := "GA"

return
cts:search(doc(),

cts:and-query((
  cts:element-value-query(xs:QName("city"), $city),
  
cts:not-query(cts:element-value-query(xs:QName("state"), $state)),
  
 
 if ($date-range-from) then
  cts:element-range-query(xs:QName("effective_date"), ">=", cert:parse-date($date-range-from))
 else
  (),  

  if ($date-range-to) then
   cts:element-range-query(xs:QName("effective_date"), "<", cert:parse-date($date-range-to))
  else
  () 
)),

("unfiltered")
)