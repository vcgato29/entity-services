xquery version "1.0-ml";

(: This module was generated by MarkLogic Entity Services. 
 : The source entity type document was Race-0.0.1
 :
 : Modification History:
 :   Generated at timestamp: 2016-04-13T13:41:03.235074-07:00
 :   Modified to lookup/denormalize runner into run, and source from JSON raw,
 :   For EA-3, revised to conform to new styles, enhancements, and bugfixes.
 :   Persisted by Charles Greer
 :   Date: 2016-07-20
 :)
module namespace race = "http://grechaw.github.io/entity-types#Race-0.0.1";

import module namespace functx   = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";
import module namespace es = "http://marklogic.com/entity-services" 
    at "/MarkLogic/entity-services/entity-services.xqy";

(:~
 : Creates a map:map representation of an entity instance from some source
 : document.
 : @param $source-node  A document or node that contains data for populating a Race
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race:extract-instance-Race(
    $source-node as node()
) as map:map
{
    let $runner-name := string($source-node/wonByRunner)
    let $runnerDoc := cts:search( collection("raw"), cts:json-property-value-query("name", $runner-name))
    let $_ := xdmp:log(("WINNER", $runner-name,  $runnerDoc))
    return json:object()
        (: This line identifies the type of this instance.  Do not change it. :)
        =>map:with('$type', 'Race')
        (: This line adds the original source document as an attachment.
         : If this entity type is not the root of a document, you should remove this.
         : If the source document is JSON, you should wrap the $source-node in xdmp:quote()
         : because you cannot preserve JSON nodes with the XML envelope verbatim.
         :)
         =>   map:with('name',                   xs:string($source-node/name))
         (: The following property is a local reference.                                     :)
         =>es:optional('comprisedOfRuns',        es:extract-array($source-node/comprisedOfRuns, function($x) { json:object()=>map:with("$type", "Run")=>map:with("$ref", xs:string($x)) } ))
         (: The following property is a local reference.                                     :)
         =>es:optional('wonByRunner',            race:extract-instance-Runner($runnerDoc))
         =>es:optional('courseLength',           xs:decimal($source-node/courseLength))
        =>map:with('$attachments', xdmp:quote($source-node))
};

(:~
    TODO make descriptive comment for extract-instance-Run
 :)
declare function race:extract-instance-Run(
    $source-node as node()
) as map:map
{
    let $runner-name := string($source-node/runByRunner)
    let $runnerDoc := cts:search( collection("raw"), cts:json-property-value-query("name", $runner-name))
    return
    json:object()
        =>map:with('$type', 'Run')
        =>map:with('$attachments', xdmp:quote($source-node))
        =>map:with('id',                     xs:string($source-node/id))
        =>map:with('date',                   xs:date($source-node/date))
        =>map:with('distance',               xs:decimal($source-node/distance))
        =>map:with('distanceLabel',          xs:string($source-node/distanceLabel))
        =>map:with('duration',               functx:dayTimeDuration((), (), xs:decimal($source-node/duration), ()))
        =>map:with('runByRunner',            race:extract-instance-Runner($runnerDoc))
};
    
(: modifying this one for JSON inputs, each a separate file :)
declare function race:extract-instance-Runner(
    $source-node as node()
) as map:map
{
    json:object()
        =>map:with('$type', 'Runner')
        =>map:with('name',                   xs:string($source-node/name))
        =>map:with('age',                    xs:int($source-node/age))
        =>map:with('gender',                 xs:string($source-node/gender))
};


declare private function race:process-duration(
    $input-value as xs:string
) as xs:dayTimeDuration?
{
    if ($input-value = ('DNS', 'DSQ'))
    then ()
    else
        let $tokens := tokenize($input-value, ":") ! xs:decimal(.)
        return functx:dayTimeDuration((), $tokens[1], $tokens[2], $tokens[3])
};

(:~
 : Creates a map:map representation of an entity instance from some source
 : document.
 : @param $source-node  A document or node that contains data for populating a Run
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race:extract-instance-Angel-Island(
$source-node as node()
) as map:map
{
(: if this $source-node is a reference without an embedded object, then short circuit. :)
json:object()
(: This line identifies the type of this instance.  Do not change it. :)
=>map:with('$type', 'Run')
=>map:with('$attachments', xdmp:quote($source-node))
=>map:with('id',                     xs:string($source-node/Bib))
=>map:with('date',                   xs:date("2016-07-23"))
=>es:optional('distance',            if ($source-node/Time = ("DNS", "DSQ")) then () else xs:decimal("13.1"))
=>es:optional('distanceLabel',       xs:string("Half Marathon"))
=>es:optional('duration',            race:process-duration($source-node/Time))
(: The following property is a local reference.                                :)
=>map:with('runByRunner',            race:extract-instance-Angel-Island-Runner($source-node))
};

(:~
 : Creates a map:map representation of an entity instance from some source
 : document.
 : @param $source-node  A document or node that contains data for populating a Runner
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race:extract-instance-Angel-Island-Runner(
$source-node as node()
) as map:map
{
json:object()
(: This line identifies the type of this instance.  Do not change it. :)
=>map:with('$type', 'Runner')
=>   map:with('name',                   xs:string($source-node/Name))
=>   map:with('age',                    xs:decimal($source-node/Age))
=>es:optional('gender',                 xs:string($source-node/Gender))

};
(:~
 : Turns an entity instance into an XML structure.
 : This out-of-the box implementation traverses a map structure
 : and turns it deterministically into an XML tree.
 : Using this function as-is should be sufficient for most use
 : cases, and will play well with other generated artifacts.
 : @param $entity-instance A map:map instance returned from one of the extract-instance
 :    functions.
 : @return An XML element that encodes the instance.
 :)
declare function race:instance-to-canonical-xml(
    $entity-instance as map:map
) as element()
{
    (: Construct an element that is named the same as the Entity Type :)
    element { map:get($entity-instance, "$type") }  {
        if ( map:contains($entity-instance, "$ref") )
        then map:get($entity-instance, "$ref")
        else
            for $key in map:keys($entity-instance)
            let $instance-property := map:get($entity-instance, $key)
            where ($key castable as xs:NCName and $key ne "$type")
            return
                typeswitch ($instance-property)
                (: This branch handles embedded objects.  You can choose to prune
                   an entity's representation of extend it with lookups here. :)
                case json:object+ 
                    return
                        for $prop in $instance-property
                        return element { $key } { race:instance-to-canonical-xml($prop) }
                (: An array can also treated as multiple elements :)
                case json:array
                    return 
                        for $val in json:array-values($instance-property)
                        return
                            if ($val instance of json:object)
                            then element { $key } { race:instance-to-canonical-xml($val) }
                            else element { $key } { $val }
                (: A sequence of values should be simply treated as multiple elements :)
                case item()+
                    return 
                        for $val in $instance-property
                        return element { $key } { $val }
                default return element { $key } { $instance-property }
    }
};


(: 
 : Wraps a canonical instance (returned by instance-to-canonical-xml())
 : within an envelope patterned document, along with the source
 : document, which is stored in an attachments section.
 : @param $entity-instance an instance, as returned by an extract-instance
 : function
 : @return A document which wraps both the canonical instance and source docs.
 :)
declare function race:instance-to-envelope(
    $entity-instance as map:map
) as document-node()
{
    document {
        element es:envelope {
            element es:instance {
                element es:info {
                    element es:title { map:get($entity-instance, '$type') },
                    element es:version { "0.0.1" }
                },
                race:instance-to-canonical-xml($entity-instance)
            },
            element es:attachments {
                map:get($entity-instance, "$attachments") 
            }
        }
    }
};


