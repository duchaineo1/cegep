node('jenkins-slave') {
    
     stage('test pipeline') {
        sh(script: """
            echo "hello"
           git clone git@bitbucket.org:o_duchaine/jenkins-test.git
           cd ./jenkins-test
           docker build . -t test
        """)
    }
}