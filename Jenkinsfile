pipeline {
    agent any
    
    parameters {
        string(defaultValue: "WebApiHiHello.sln", description: 'name of solution file', name: 'solutionName')
		string(defaultValue: "api", description: 'name of docker image', name: 'dockerImage')
		string(defaultValue: "ApiCrudTest.Tests/ApiCrudTest.Tests.csproj", description: 'name of test file', name: 'testName')
		string(defaultValue:"samishra/basic-api", description: 'Repository Name', name: 'repositoryName')
		string(defaultValue:"v1.0", description: 'Docker image Tag', name: 'tag')
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
		stage('Docker Build'){
			steps{
				bat 'docker build --tag=%dockerImage% --file=Dockerfile .'
			}
		}
		stage('Docker Login'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'f159b697-37a1-4e3f-acc2-3d83b16261b4	', passwordVariable: 'password', usernameVariable: 'username')]){
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
				bat 'docker run -p 1112:1112 --rm %dockerImage%'
			}
		}
    }}