xquery version '1.0-ml';
module namespace model_2ns-from-model_1ns
    = 'http://marklogic.com/ns2#Model_2ns-0.0.1-from-Model_1ns-0.0.1';

import module namespace es = 'http://marklogic.com/entity-services'
    at '/MarkLogic/entity-services/entity-services.xqy';

declare namespace cust = 'http://marklogic.com/customer';
 declare namespace ord = 'http://marklogic.com/order';
 declare namespace sup = 'http://marklogic.com/super';


declare option xdmp:mapping 'false';

(:
 This module was generated by MarkLogic Entity Services.
 Its purpose is to create instances of entity types
 defined in
 Model_2ns, version 0.0.1
 from documents that were persisted according to model
 Model_1ns, version 0.0.1


 For usage and extension points, see the Entity Services Developer's Guide

 https://docs.marklogic.com/guide/entity-services

 Generated at timestamp: 2017-10-25T11:59:32.065428-07:00

 Target Model Model_2ns-0.0.1 Info:

 Type Customer: 
    primaryKey: CustomerID, ( in source: CustomerId )
    required: None, ( in source: CustomerId )
    range indexes: CustomerID, ( in source: CustomerId )
    word lexicons: CustomerID, ( in source: None )
    namespace: None, ( in source: http://marklogic.com/customer )
    namespace prefix: None, ( in source: cust )
 
 Type Product: 
    primaryKey: ProductID, ( in source: None )
    required: ProductID, ( in source: ProductID )
    range indexes: ProductID, ( in source: UnitPrice )
    word lexicons: None, ( in source: None )
    namespace: None, ( in source: None )
    namespace prefix: None, ( in source: None )
 
 Type Order: 
    primaryKey: OrderID, ( in source: None )
    required: None, ( in source: OrderID )
    range indexes: None, ( in source: OrderDate )
    word lexicons: CustomerID, ( in source: OrderDetails )
    namespace: http://marklogic.com/order, ( in source: None )
    namespace prefix: ord, ( in source: None )
 
 Type OrderDetail: 
    primaryKey: None, ( in source: None )
    required: None, ( in source: None )
    range indexes: None, ( in source: None )
    word lexicons: None, ( in source: None )
    namespace: None, ( in source: None )
    namespace prefix: None, ( in source: None )
 
 Type Superstore: 
    missing from source model.
    primaryKey: OrderID, ( in source: None )
    required: None, ( in source: None )
    range indexes: None, ( in source: None )
    word lexicons: Ship-Address, ( in source: None )
    namespace: http://marklogic.com/super, ( in source: None )
    namespace prefix: sup, ( in source: None )
 
 Type ShipDetails: 
    missing from source model.
    primaryKey: None, ( in source: None )
    required: None, ( in source: None )
    range indexes: None, ( in source: None )
    word lexicons: None, ( in source: None )
    namespace: None, ( in source: None )
    namespace prefix: None, ( in source: None )
 
:)


(:~
 : Creates a map:map instance representation of the target
 : entity type Customer from an envelope document
 : containing a source entity instance, that is, instance data
 : of type Customer, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type Customer.
 : @return A map:map instance that holds the data for Customer,
 :  version 0.0.1.
 :)

declare function model_2ns-from-model_1ns:convert-instance-Customer(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'Customer')

    (: The following property was missing from the source type.
       The XPath will not up-convert without intervention.  :)
    let $CustomerID := $source-node/cust:CustomerID ! xs:string(.)
    let $CustomerId := $source-node/cust:CustomerId ! xs:string(.)
    let $CompanyName := $source-node/cust:CompanyName ! xs:string(.)
    let $Country := $source-node/cust:Country ! xs:string(.)
    let $Address := $source-node/cust:Address ! xs:string(.)

    return
        es:init-instance($source, "Customer")
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "Customer" entity type. :)
    =>   map:with('CustomerID',   $CustomerID)
    (: The following properties are in the source, but not the target: 
    =>es:optional('NO TARGET',    $CustomerId)
    =>es:optional('NO TARGET',     $CompanyName)
    =>es:optional('NO TARGET', $Country)
    =>es:optional('NO TARGET', $Address)
  :)

};
    
(:~
 : Creates a map:map instance representation of the target
 : entity type Order from an envelope document
 : containing a source entity instance, that is, instance data
 : of type Order, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type Order.
 : @return A map:map instance that holds the data for Order,
 :  version 0.0.1.
 :)

declare function model_2ns-from-model_1ns:convert-instance-Order(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'Order')

    let $OrderID := $source-node/OrderID ! xs:integer(.)
    let $extract-scalar-Customer := 
       es:init-instance(?, 'Customer')

    let $CustomerID := $source-node/CustomerID ! $extract-scalar-Customer(.)
    let $OrderDate := $source-node/OrderDate ! xs:dateTime(.)
    (: The following property was missing from the source type.
       The XPath will not up-convert without intervention.  :)
    let $ShippedDate := $source-node/ShippedDate ! xs:dateTime(.)
    let $ShipAddress := $source-node/ShipAddress ! xs:string(.)
    let $extract-reference-OrderDetail := 
        function($path) { 
         if ($path/*)
         then model_2ns-from-model_1ns:convert-instance-OrderDetail($path)
         else es:init-instance($path, 'OrderDetail')
         }

    let $OrderDetails := es:extract-array($source-node/OrderDetails/*, $extract-reference-OrderDetail)

    return
        es:init-instance($source, "Order")
        =>es:with-namespace('http://marklogic.com/order','ord')
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "Order" entity type. :)
    =>   map:with('OrderID',   $OrderID)
    =>es:optional('CustomerID',   $CustomerID)
    =>es:optional('OrderDate',   $OrderDate)
    =>es:optional('ShippedDate',   $ShippedDate)
    =>es:optional('ShipAddress',   $ShipAddress)
    =>es:optional('OrderDetails',   $OrderDetails)

};
    
(:~
 : Creates a map:map instance representation of the target
 : entity type OrderDetail from an envelope document
 : containing a source entity instance, that is, instance data
 : of type OrderDetail, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type OrderDetail.
 : @return A map:map instance that holds the data for OrderDetail,
 :  version 0.0.1.
 :)

declare function model_2ns-from-model_1ns:convert-instance-OrderDetail(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'OrderDetail')

    let $extract-reference-Product := 
        function($path) { 
         if ($path/*)
         then model_2ns-from-model_1ns:convert-instance-Product($path)
         else es:init-instance($path, 'Product')
         }

    let $hasProductID := $source-node/hasProductID/* ! $extract-reference-Product(.)
    let $hasUnitPrice := $source-node/hasUnitPrice ! xs:double(.)
    let $Quantity := $source-node/Quantity ! xs:integer(.)

    return
        es:init-instance($source, "OrderDetail")
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "OrderDetail" entity type. :)
    =>es:optional('hasProductID',   $hasProductID)
    =>es:optional('hasUnitPrice',   $hasUnitPrice)
    =>es:optional('Quantity',   $Quantity)

};
    
(:~
 : Creates a map:map instance representation of the target
 : entity type Product from an envelope document
 : containing a source entity instance, that is, instance data
 : of type Product, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type Product.
 : @return A map:map instance that holds the data for Product,
 :  version 0.0.1.
 :)

declare function model_2ns-from-model_1ns:convert-instance-Product(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'Product')

    let $ProductID := $source-node/ProductID ! xs:integer(.)
    let $ProductName := $source-node/ProductName ! xs:string(.)
    let $UnitPrice := $source-node/UnitPrice ! xs:string(.)
    let $SupplierID := $source-node/SupplierID ! xs:string(.)
    let $Discontinued := $source-node/Discontinued ! xs:string(.)

    return
        es:init-instance($source, "Product")
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "Product" entity type. :)
    =>   map:with('ProductID',   $ProductID)
    (: The following properties are in the source, but not the target: 
    =>es:optional('NO TARGET',     $ProductName)
    =>es:optional('NO TARGET',   $UnitPrice)
    =>es:optional('NO TARGET',    $SupplierID)
    =>es:optional('NO TARGET',      $Discontinued)
  :)

};
    
(:~
 : Creates a map:map instance representation of the target
 : entity type ShipDetails from an envelope document
 : containing a source entity instance, that is, instance data
 : of type ShipDetails, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type ShipDetails.
 : @return A map:map instance that holds the data for ShipDetails,
 :  version 0.0.1.
 :)

(: Type ShipDetails is not in the source model.
 : XPath expressions are created as though there were no change between source and target type.
 :)
declare function model_2ns-from-model_1ns:convert-instance-ShipDetails(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'ShipDetails')

    let $Province := $source-node/Province ! xs:string(.)
    let $Region := $source-node/Region ! xs:string(.)
    let $ShipMode := $source-node/ShipMode ! xs:string(.)
    let $ShippingCost := $source-node/ShippingCost ! xs:double(.)

    return
        es:init-instance($source, "ShipDetails")
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "ShipDetails" entity type. :)
    =>es:optional('Province',   $Province)
    =>es:optional('Region',   $Region)
    =>es:optional('ShipMode',   $ShipMode)
    =>es:optional('ShippingCost',   $ShippingCost)

};
    
(:~
 : Creates a map:map instance representation of the target
 : entity type Superstore from an envelope document
 : containing a source entity instance, that is, instance data
 : of type Superstore, version 0.0.1.
 : @param $source  An Entity Services envelope document (<es:envelope>)
 :  or a canonical XML instance of type Superstore.
 : @return A map:map instance that holds the data for Superstore,
 :  version 0.0.1.
 :)

(: Type Superstore is not in the source model.
 : XPath expressions are created as though there were no change between source and target type.
 :)
declare function model_2ns-from-model_1ns:convert-instance-Superstore(
    $source as node()
) as map:map
{
    let $source-node := es:init-translation-source($source, 'Superstore')

    let $OrderID := $source-node/OrderID ! xs:integer(.)
    let $CustomerID := $source-node/CustomerID ! xs:string(.)
    let $OrderDate := $source-node/OrderDate ! xs:dateTime(.)
    let $ShippedDate := $source-node/ShippedDate ! xs:dateTime(.)
    let $ProductName := $source-node/ProductName ! xs:string(.)
    let $UnitPrice := $source-node/UnitPrice ! xs:double(.)
    let $Quantity := $source-node/Quantity ! xs:integer(.)
    let $Discount := $source-node/Discount ! xs:string(.)
    let $extract-scalar-ShipDetails := 
       es:init-instance(?, 'ShipDetails')

    let $Ship-Address := es:extract-array($source-node/Ship-Address, $extract-scalar-ShipDetails)

    return
        es:init-instance($source, "Superstore")
        =>es:with-namespace('http://marklogic.com/super','sup')
       (: Copy attachments from source document to the target :)
        =>es:copy-attachments($source-node)
    (: The following lines are generated from the "Superstore" entity type. :)
    =>   map:with('OrderID',   $OrderID)
    =>es:optional('CustomerID',   $CustomerID)
    =>es:optional('OrderDate',   $OrderDate)
    =>es:optional('ShippedDate',   $ShippedDate)
    =>es:optional('ProductName',   $ProductName)
    =>es:optional('UnitPrice',   $UnitPrice)
    =>es:optional('Quantity',   $Quantity)
    =>es:optional('Discount',   $Discount)
    =>es:optional('Ship-Address',   $Ship-Address)

};
    