node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           kubectl get pods -n jenkins
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
        """)
    }
}
