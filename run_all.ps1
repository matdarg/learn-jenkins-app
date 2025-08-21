# variable for the path to the Jenkins project
$jenkinsProjectPath = "C:\Users\matda\jenkins_project"
# variable for docker compose file path
$dockerPath = "$jenkinsProjectPath\install-jenkins-docker"
# variable for the path to the Jenkins home directory
$jenkinsAppPath = "$jenkinsProjectPath\learn-jenkins-app"

# Run docker compose down in the background
Start-Job -ScriptBlock {
    try {
        Set-Location $dockerPath
        docker compose down
        docker compose up -d
        Start-Process "chrome.exe" "http://localhost:8080"
    } catch {
        Write-Error "Docker compose or Chrome failed: $_"
    }
}

# Open Chrome to the Jenkins Udemy course
Start-Process "chrome.exe" "https://cognizant.udemy.com/course/jenkins-ci-cd-pipelines-devops-for-beginners"


Start-Process "chrome.exe" "http://localhost:3000"

# start vscode in the Jenkins app directory
Start-Process "code" -ArgumentList $jenkinsAppPath

# npm start start-process in a new PowerShell window without opening the browser
Start-Process "powershell.exe" -ArgumentList "cd $jenkinsAppPath; npm start"
# get jobs to wait for completion
$jobs = Get-Job
# wait for all jobs to complete
Wait-Job -Job $jobs