# Argo CDとArgo CD Image Updaterのtemplate
## 手順
1. Argo CDのsetup  
    a. Argo CDのinstall
    ```
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```
    b. Argo CD CLIのinstall
    ```
    参考: https://github.com/argoproj/argo-cd/releases
    ```
    c. Argo CD API serverにアクセスできるようにする
    ```
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```
    d. Argo CDのadmin passwordを取得する
    ```
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
    ```
2. Argo CD Image Updaterのsetup
```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
```
3. values.yamlに適切な値を入れて、application.yamlをdeployする

## 参考
Argo CD: https://argo-cd.readthedocs.io/  
Argo CD Image Updater: https://argocd-image-updater.readthedocs.io/

## 注意
Argo CDの設定をHelmにしてみたが、まだ動作確認してない
