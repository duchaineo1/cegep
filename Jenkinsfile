node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           apt-get install -y curl
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
           curl -s http://551ab93f89bd.ngrok.io/api/v1/namespaces/default/pods --header "Authorization : Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImlJZFdfWWF2Yy1zbTBGR1hrdHlOQWlvSWM0OUZWdXNmbnpyZFk4TEdocG8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InNhLXRlc3QtdG9rZW4tNjY3N2wiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoic2EtdGVzdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjM3ZjBmZGVmLTZlYmYtNDY2My04YmNlLTIwYTU5Yzg4NjY3YiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OnNhLXRlc3QifQ.swxiwxtF-MkmCsDwri-6ql1OuguOWVUajW92yb607dAJpdNA8OGwvyaCmM7CmAA6rky8WM2sM8UnJGHsRF7SRxgPsiHdR697oaLZ7OCTwD4regmnASavhGmP2yn1GiAysqNSWiDT4yyu5i6YphUAkiNfk6Mo_zMYY0Vmgpnv6gEvH3FgTIQktVZ0ewf5R5qWhnyTjh7r6H-yPmn0qI33AmfXxcNKU9N2u4_0GWrA7Jx4cIjd5U-ac0IsxqrMcvSAl8NpkNslC_HGXDfFW4SRF_CulhE9uve_dASZD7Hyr2hpjou7BWZU6mPt-RqWgYa1g2e0UQBftsMaej-II-kHeQ" --cacert ca.crt
        """)
    }
}
