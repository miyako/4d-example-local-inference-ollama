---
layout: default
---

![version](https://img.shields.io/badge/version-21%2B-3B69E9)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-example-local-inference-ollama)](LICENSE)

# Use Ollama from 4D

[dependencies](https://github.com/miyako/4d-example-local-inference-ollama/blob/main/local-inference/Project/Sources/dependencies.json)

* [`miyako/ollama`](https://github.com/miyako/ollama)
* [`4d/4D-AIKit`](https://github.com/4d/4D-AIKit)

#### Start Ollama

Typically in the *On Startup* database method:

```4d
var $folder : 4D.Folder
$folder:=Folder(Folder("/PACKAGE/").platformPath; fk platform path).parent.folder("models")

var $ollama : cs.ollama.server
$ollama:=cs.ollama.server.new()

var $isRunning : Boolean
$isRunning:=$ollama.isRunning()

$ollama.start({\
host: "127.0.0.1:8080"; \
content_length: 4096; \
keep_alive: "5m"; \
models: $folder})
```

Specify the folder where models are to be stored.

#### Terminate Ollama

Typically in the *On Exit* database method:

```4d
var $llama : cs.ollama.server
$llama:=cs.ollama.server.new()
$llama.terminate()
```

#### Official Models

Find a model officially hosted on [ollama.com](https://ollama.com/search).

For example to install `nomic-embed-text` do the following:

```4d
var $ollama : cs.ollama.ollama
$ollama:=cs.ollama.ollama.new()
$ollama.pull({name:"nomic-embed-text"})
```

If you want a callback then

```4d
#DECLARE($params : Object)

If (Count parameters=0)
    
    CALL WORKER(1; Current method name; {})
    
Else 
    
    var $ollama : cs.ollama.ollama
    $ollama:=cs.ollama.ollama.new()
    $ollama.pull({name: "nomic-embed-text"; data: {message: "done!"}}; Formula(ALERT($2.context.message)))
    
End if 
```

Whatever object you pass in `data` is sent to the callback formula in `$2.context`

```4d
#DECLARE($worker : 4D.SystemWorker; $params : Object)

$data:=$params.context
```

Now the model will be included in the list of available models:

```4d
var $ollama : cs.ollama.ollama
$ollama:=cs.ollama.ollama.new()
var $models : Collection
$models:=$ollama.list()
```

#### Custom Models

Ollama is based on llama.cpp so most GGUF models are compatible. For instance you may use a LLaMA-2 or LLaMA-3 model from Hugging Face.

To use [elyza/Llama-3-ELYZA-JP-8B-GGUF](https://huggingface.co/elyza/Llama-3-ELYZA-JP-8B-GGUF)

* Download the GGUF file 
* Create a folder in the models folder you specify in `.start`
* Move the GGUF file to the folder and create a `Modelfile`

The file format is described in the official [doc](https://docs.ollama.com/modelfile)

* You may use an existing `Modelfile` of an official model of the same family as reference

e.g. [models/elyza-8b-q4_k_m/Modelfile](https://github.com/miyako/4d-example-local-inference-ollama/blob/main/models/elyza-8b-q4_k_m/Modelfile)

Use the `Modelfile` to register the custom model 

```4d
#DECLARE($params : Object)

If (Count parameters=0)
    
    CALL WORKER(1; Current method name; {})
    
Else 
    
    var $file : 4D.File
    $file:=Folder(Folder("/PACKAGE/").platformPath; fk platform path).parent.file("models/elyza-8b-q4_k_m/Modelfile")
    
    var $ollama : cs.ollama.ollama
    $ollama:=cs.ollama.ollama.new()
    $ollama.create({name: "elyza:jp8b"; file: $file; data: {message: "done!"}}; Formula(ALERT($2.context.message))))
    
End if 
```
