//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $file : 4D:C1709.File
	$file:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("models/elyza-8b-q4_k_m/Modelfile")
	
	var $ollama : cs:C1710.ollama.ollama
	$ollama:=cs:C1710.ollama.ollama.new()
	$ollama.create({name: "elyza:jp8b"; file: $file; data: $file}; Formula:C1597(onResponse))
	
End if 