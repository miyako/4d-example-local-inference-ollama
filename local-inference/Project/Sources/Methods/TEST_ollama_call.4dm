//%attributes = {}
var $AIClient : cs:C1710.AIKit.OpenAI

$AIClient:=cs:C1710.AIKit.OpenAI.new()
$AIClient.baseURL:="http://127.0.0.1:8080/v1"

var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()

var $responseModels : cs:C1710.AIKit.OpenAIModelListResult
$responseModels:=$AIClient.models.list()

If ($responseModels.success)
	var $models : Collection
	$models:=$responseModels.models
	If ($models.length#0)
		
		var $model : Text
		$model:=$models.first().id
		
		var $text : Text
		$text:="4D 21でローカルAIを使用するためのコンポーネント"
		
		var $responseEmbeddings : cs:C1710.AIKit.OpenAIEmbeddingsResult
		$responseEmbeddings:=$AIClient.embeddings.create($text; $model; $options)
		
	End if 
End if 