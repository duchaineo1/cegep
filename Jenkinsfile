node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
            echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
        """)
    }
}
