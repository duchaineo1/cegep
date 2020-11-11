pipeline {
  agent { label 'kubepod' }
  stages {
    stage('Checkout Source') {
      steps {
        git url:'https://github.com/duchaineo1/cegep.git'
      }
    }
    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "myweb.yml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}
