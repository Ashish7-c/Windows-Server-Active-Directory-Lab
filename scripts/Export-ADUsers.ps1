
# Active Directory Employee Report
# Windows Server 2025 Help Desk Lab

Import-Module ActiveDirectory -ErrorAction Stop

# Company Organizational Unit
$SearchBase = "OU=AC-Company,DC=corp,DC=aclab,DC=test"

# Report location
$ReportFolder = "C:\LabReports"
$ReportFile = "$ReportFolder\Employee_Report.csv"

# Create reports folder if needed
New-Item -Path $ReportFolder -ItemType Directory -Force | Out-Null

# Get all company employee accounts
$Employees = Get-ADUser -Filter * -SearchBase $SearchBase -Properties Enabled

# Export employee information
$Employees |
    Select-Object Name, SamAccountName, Enabled |
    Sort-Object Name |
    Export-Csv -Path $ReportFile -NoTypeInformation -Encoding UTF8

Write-Host "Employee report generated successfully!"
Write-Host "Total employees: $($Employees.Count)"
Write-Host "Report saved to: $ReportFile"
