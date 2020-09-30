#   Programmer: Nurdiyana Md Ali
#   Date:       28th September 2020
#   Version:    v 1.0
#   Purpose:    To set up the tagUI URL to point to the current month's 
#               download link and run the tagUI in headless Chrome mode. 
#               Script will be run as monthly scheduled jobs.

# Fully formed URL is: https://www.catalog.update.microsoft.com/Search.aspx?q=2020-09%202016

# declare the main Microsoft URL site for catalog update
$mainURL = "https://www.catalog.update.microsoft.com/Search.aspx?q="
# declare the current year and month to be appended to the URL search string
$currentDate = Get-Date -Format "yyyy-MM"
# declare Windows Server 2016 as the search string
$targetOS = "2016"
# make a new directory with the curent date, if does not exist
If(!(test-path C:\inetpub\wwwroot\$targetOS\$currentDate\))
{
    New-Item -Path "C:\inetpub\wwwroot\$targetOS\" -Name "$currentDate" -ItemType Directory -Force
}
# append all the search queries and set it as the URL
$fullURL = "$mainURL$currentDate%20$targetOS"
#Write-Output $fullURL
# declare the location of the tagUI file
$tagFile = "C:\Automation\windows_update.tag"
# declare the exact location of the folder hosted on IIS
$tagFileRun = "C:\inetpub\wwwroot\$targetOS\$currentDate\windows_update.tag"
# get the content of the file for processing
$content = Get-Content $tagFile
# replace the line that begins with https:// with the new URL, save it on the new tagUI file
$content -replace '(^https\:\/\/.*$)',"$fullURL" | Set-Content $tagFileRun
# run the tagui application, set the tagUI file and run it as headless (-h)
cmd /c C:\tagui\src\tagui $tagFileRun -h
