node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           ip a
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
           docker run -p 3000 -t test:latest
        """)
    }
}
