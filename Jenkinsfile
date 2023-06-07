pipeline {
  agent any
  tools {
      terraform 'Terraform1'
  }
  parameters {
      choice(choices: ['apply', 'destroy'], description: 'terraform apply or destroy', name: 'terraform_parameter')
  }
  stages {
    stage('Git-Checkout') {
	  steps {
	    git branch: 'main', changelog: false, poll: false, url: 'https://github.com/olaoruku007/terraform-vpc.git'
      }
	}
    stage('terraform init') {
	  steps {
	    sh 'terraform init'
	  }    
        
    }

    stage('terraform plan') {
	  steps {
	    sh 'terraform plan'
	  }    
        
    }

    stage('terraform apply/destroy') {
	  steps {
	    sh 'terraform "${terraform_parameter}" --auto-approve'
	  }    
        
    }

  }
 
}
