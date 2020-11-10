node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           apt-get install -y curl
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
           curl -s http://551ab93f89bd.ngrok.io/api/v1/namespaces/default/pods -XPOST -H 'Content-Type: application/json' -d@pod.json
        """)
    }
}
