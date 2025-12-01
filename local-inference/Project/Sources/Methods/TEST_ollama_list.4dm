//%attributes = {"invisible":true}
var $ollama : cs:C1710.ollama.ollama
$ollama:=cs:C1710.ollama.ollama.new()
var $models : Collection
$models:=$ollama.list()