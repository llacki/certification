import module "http://marklogic.com/xdmp/tde" at "/MarkLogic/tde.xqy";

let $salary-template :=
<template xmlns="http://marklogic.com/xdmp/tde">
    <context>/envelope/content/employee</context>
    <rows>
        <row>
            <schema-name>certification</schema-name>
            <view-name>employee</view-name>
            <columns>
                <column>
                    <name>emp_id</name>
                    <scalar-type>string</scalar-type>
                    <val>emp_id</val>
                    <invalid-values>ignore</invalid-values>
                </column>
                <column>
                    <name>base_salary</name>
                    <scalar-type>decimal</scalar-type>
                    <val>base_salary</val>
                    <invalid-values>ignore</invalid-values>
                </column>
                <column>
                    <name>bonus</name>
                    <scalar-type>decimal</scalar-type>
                    <val>bonus</val>
                    <invalid-values>ignore</invalid-values>
                </column>
            </columns>
        </row>
    </rows>
</template>



return (: tde:validate($employee-template) :)   tde:node-data-extract(fn:doc("/accounting/order-14502.xml"), $employee-template) 
