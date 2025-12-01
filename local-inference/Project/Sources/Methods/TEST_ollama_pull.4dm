//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $ollama : cs:C1710.ollama.ollama
	$ollama:=cs:C1710.ollama.ollama.new()
	$ollama.pull({name: "nomic-embed-text"; data: {message: "done!"}}; Formula:C1597(ALERT:C41($2.context.message)))
	
End if 