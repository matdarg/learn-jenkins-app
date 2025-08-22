# variable for the path to the Jenkins project
$jenkinsProjectPath = "C:\Users\matda\jenkins_project"
# variable for docker compose file path
$dockerPath = "$jenkinsProjectPath\install-jenkins-docker"
# variable for the path to the Jenkins home directory
$jenkinsAppPath = "$jenkinsProjectPath\learn-jenkins-app"

# Run docker compose down and up in a new PowerShell window
Start-Process "powershell.exe" -ArgumentList "cd $dockerPath; docker compose down; docker compose up -d"

# npm start start-process in a new PowerShell window without opening the browser
Start-Process "powershell.exe" -ArgumentList "cd $jenkinsAppPath; npm start -- --no-browser"

# Open chrome to the Jenkins Udemy course and react app and Jenkins server
Start-Process "chrome.exe" "https://cognizant.udemy.com/course/jenkins-ci-cd-pipelines-devops-for-beginners"
Start-Process "chrome.exe" "http://localhost:3000"
Start-Process "chrome.exe" "http://localhost:8080"

# start vscode in the Jenkins app directory
Start-Process "code" -ArgumentList $jenkinsAppPath
