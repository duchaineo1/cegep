node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
           ip a
           echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           docker build . -t test
           docker run -p 5000:5000 -t test:latest
        """)
    }
}
