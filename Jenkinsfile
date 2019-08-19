pipeline {
    agent any
    
    parameters {
        string(defaultValue: "WebApiHiHello.sln", description: 'name of solution file', name: 'solutionName')
		string(defaultValue: "api", description: 'name of docker image', name: 'dockerImage')
		string(defaultValue: "ApiCrudTest.Tests/ApiCrudTest.Tests.csproj", description: 'name of test file', name: 'testName')
		string(defaultValue:"samishra/basic-api", description: 'Repository Name', name: 'repositoryName')
		string(defaultValue:"v1.0", description: 'Docker image Tag', name: 'tag')	
		string(defaultValue:"1112", description: 'port assigned for container', name: 'dockerPort')
		string(defaultValue:"1112", description: 'mapped local port', name: 'localPort')
		string(defaultValue:"23f6d9c3a43e1c5317d1d80777cfa0e6027f5a49", description: 'Token id', name: 'keyToken')
		string(defaultValue:"f159b697-37a1-4e3f-acc2-3d83b16261b4", description: 'credentialId', name: 'credentialId')
    }
    
    stages { 

        stage('Build') {
            
            steps{
                echo 'Build stage'
                bat 'dotnet build %solutionName% -p:Configuration=release -v:q'
            }
        }
        stage('Test') {
            
            steps{
                echo 'Test stage'
                bat 'dotnet test %testName%'
            }
        }
        stage('Publish') {
            
            steps{
                echo 'Publish stage'
                bat 'dotnet publish %solutionName% -c Release -o Publish'
            }
        }
		stage('SonarQube Analysis') {
        	
        	steps{
				bat 'dotnet %sonarPath% begin /d:sonar.login=%sonarID% /d:sonar.password=%sonarPassword% /k:"%23f6d9c3a43e1c5317d1d80777cfa0e6027f5a49%"'
				bat 'dotnet build'
				bat 'dotnet %sonarPath% end /d:sonar.login=%sonarID% /d:sonar.password=%sonarPassword%'
        	}
        }
		stage('Docker Build'){
			steps{
				bat 'docker build --tag=%dockerImage% --file=Dockerfile .'
			}
		}
		stage('Docker Login'){
            steps{
                withCredentials([usernamePassword(credentialsId: '%credentialId%', passwordVariable: 'password', usernameVariable: 'username')]){
                    bat 'docker login --username=%username% --password=%password%'
                }
            }
			}
		stage('Docker Push'){
			steps{
				bat 'docker tag %dockerImage% %repositoryName%:%tag%'
				bat 'docker push %repositoryName%:%tag%'
			}
		}
		stage('Docker Pull'){
			steps{
				bat 'docker pull %repositoryName%:%tag%'
			}
		}
		stage('Docker Deploy'){
			steps{
				bat 'docker run -p %dockerPort%:%localPort% --rm %dockerImage%'
			}
		}
    }}