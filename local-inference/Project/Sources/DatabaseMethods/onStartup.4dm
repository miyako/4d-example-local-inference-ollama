var $folder : 4D:C1709.Folder
$folder:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.folder("models")

var $ollama : cs:C1710.ollama.server
$ollama:=cs:C1710.ollama.server.new()

var $isRunning : Boolean
$isRunning:=$ollama.isRunning()

$ollama.start({\
host: "127.0.0.1:8080"; \
content_length: 4096; \
keep_alive: "5m"; \
models: $folder})