pipeline {
    agent any
    
    parameters {
        string(defaultValue: "WebApiHiHello.sln", description: 'name of solution file', name: 'solutionName')
		string(defaultValue: "api", description: 'name of docker image', name: 'dockerImage')
		string(defaultValue: "ApiCrudTest.Tests/ApiCrudTest.Tests.csproj", description: 'name of test file', name: 'testName')
		string(defaultValue: "WebApiHiHello/Publish", description: 'path of publish', name: 'publishPath')
		string(defaultValue: "WebApiHiHello.dll", description: 'dll filename', name: 'dllFile')
		string(defaultValue: "samishra", description: 'name of registry', name: 'registryName')
		string(defaultValue:"basic-api", description: 'Repository Name', name: 'repositoryName')
		string(defaultValue:"v1.0", description: 'Docker image Tag', name: 'tag')	
		string(defaultValue:"1112", description: 'port assigned for container', name: 'dockerPort')
		string(defaultValue:"1112", description: 'mapped local port', name: 'localPort')
		string(defaultValue:"23f6d9c3a43e1c5317d1d80777cfa0e6027f5a49", description: 'Token id', name: 'keyToken')
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
				withCredentials([usernamePassword(credentialsId: '1df07212-97bf-4d08-85c6-706f69dc5e45	', passwordVariable: 'password', usernameVariable: 'username')]){
				bat 'dotnet %sonarPath% begin /d:sonar.login=%username% /d:sonar.password=%password% /k:"%keyToken%"'
				bat 'dotnet build'
				bat 'dotnet %sonarPath% end /d:sonar.login=%username% /d:sonar.password=%password%'
        	}
        }}
		stage('Docker Build'){
			steps{
				bat 'docker build --build-arg publish_path=%publishPath% --tag=%dockerImage% --file=Dockerfile .'
			}
		}
		stage('Docker Login'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'f159b697-37a1-4e3f-acc2-3d83b16261b4', passwordVariable: 'password', usernameVariable: 'username')]){
                    bat 'docker login --username=%username% --password=%password%'
                }
            }
			}
		stage('Docker Push'){
			steps{
				bat 'docker tag %dockerImage% %registryName%/%repositoryName%:%tag%'
				bat 'docker push %registryName%/%repositoryName%:%tag%'
			}
		}
		stage('Docker Pull'){
			steps{
				bat 'docker pull %registryName%/%repositoryName%:%tag%'
			}
		}
		stage('Docker Deploy'){
			steps{
				bat 'docker run -p %dockerPort%:%localPort% -e SOLUTION_DLL=%dllFile% %dockerImage%'
			}
		}
		
    }}