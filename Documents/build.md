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

* トリガーがhttpの時
```
- --trigger-http
```
* トリガーがpub/subの時
```
 - --trigger-topic=<適当なトピック名>
```
トピックが作成されていない場合、ここで指定したトピックが作成される。  

<br>
<br>

## ジョブ作成関連  
--- 
  
crontabで5分おき
https://www.shigemk2.com/entry/20120418/1334737651

<br>

* 認証を通す  
https://cloud.google.com/docs/authentication/getting-started#command-line  

* ロールについて  
https://cloud.google.com/iam/docs/understanding-roles

* サービスアカウントにsecret managerアクセス権限を付与  
https://dev.classmethod.jp/articles/secret-manager-access-from-cloudfunctions-python/  
```
//例
make gcloud args="secrets add-iam-policy-binding <secret名> --member=\"serviceAccount:<上の認証で作ったキーファイル記載のclient_email>\" --role=\"roles/secretmanager.secretAccessor\""
```