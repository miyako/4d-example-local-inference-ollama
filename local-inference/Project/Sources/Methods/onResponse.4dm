//%attributes = {"invisible":true}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

var $text : Text
$text:=$worker.response
var $file : 4D:C1709.File
$file:=$params.context

