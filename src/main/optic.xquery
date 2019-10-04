import module namespace op="http://marklogic.com/optic" at "/MarkLogic/optic.xqy"; 
declare default function namespace "http://marklogic.com/optic"; 

let $map := map:map()

let $employee := op:from-view("certification", "employee")
let $salary := op:from-view("certification", "salary")

return
$employee
=> op:join-inner($salary, op:on(op:view-col("employee", "emp_id"), op:view-col("salary", "emp_id")))
=> select((op:view-col("employee",'first_name'), op:view-col("employee",'last_name'), sum(col("base_salary"), col("bonus"))))
=> order-by("product")
=> result()