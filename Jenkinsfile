node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           ip a
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
           docker run --rm alpine /bin/sh -c "echo hello world"
        """)
    }
}
