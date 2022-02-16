```
API [cloudresourcemanager.googleapis.com] not enabled on project
~~
```  

こんな感じのことを言われたら、  
<https://console.cloud.google.com/apis/api/cloudresourcemanager.googleapis.com/metrics?project=my-cloud-function-340512>  
を有効にする必要あり。

<br>

* デプロイする関数と実行ファイル名は合わせる必要ありそう。  
<br>

* poetryでderequirements.txtを作成

```
poetry export -f requirements.txt -o requirements.txt
```
