pipeline {
    agent any
    
    parameters {
        string(defaultValue: "WebApiHiHello.sln", description: 'name of solution file', name: 'solutionName')
		string(defaultValue: "api", description: 'name of docker image', name: 'dockerImage')
		string(defaultValue: "ApiCrudTest.Tests/ApiCrudTest.Tests.csproj", description: 'name of test file', name: 'testName')
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
		stage('Deploy') {
            
            steps{
                echo 'Deploy stage'
                bat 'docker build --tag=%dockerImage% .'
				bat 'docker run --rm -p 1112:1112 %dockerImage% '
            }
        }

    }
}