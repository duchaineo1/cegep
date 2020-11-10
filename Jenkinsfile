node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
            echo "hello"
           git clone https://github.com/duchaineo1/cegep.git
           cd ./cegep
           apt-get install -y docker.io
           systemctl start docker
           docker build . -t test
        """)
    }
}
