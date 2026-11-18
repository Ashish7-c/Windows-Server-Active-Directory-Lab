# Active Directory Help Desk Lab — Test Results

## Project Overview

This document records the testing and verification performed during my Windows Server 2025 Active Directory Help Desk Lab.

The objective was to verify that Active Directory, DNS, Windows 11 domain authentication, Group Policy, shared-folder permissions, and PowerShell automation worked correctly in a virtualized environment.

## 1. Lab Environment

| Component | Configuration |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Server Operating System | Windows Server 2025 |
| Domain Controller | AC-LAB-DC01 |
| Client Operating System | Windows 11 |
| Client Computer | AC-LAB-PC01 |
| Active Directory Domain | corp.aclab.test |
| Domain Controller IP | 192.168.50.10 |
| Windows 11 IP | 192.168.50.20 |
| Internal Network | AC-LAB |

## 2. Active Directory and DNS Verification

**Test Objective:** Verify that Active Directory Domain Services and DNS were configured correctly.

**Test Performed:**

- Confirmed that the `corp.aclab.test` domain was created.
- Verified that AC-LAB-DC01 was operating as the Domain Controller.
- Confirmed DNS resolution from Windows 11.
- Verified the Active Directory LDAP SRV record.
- Checked the Organizational Units under AC-Company.

**Commands Used:**

`nslookup corp.aclab.test`

`nslookup -type=SRV _ldap._tcp.dc._msdcs.corp.aclab.test`

**Result:** PASS

The Windows 11 workstation successfully resolved the Active Directory domain and located the Domain Controller.

## 3. Windows 11 Domain Join Verification

**Test Objective:** Confirm that the Windows 11 workstation was joined to Active Directory.

**Command Used:**

`Get-CimInstance Win32_ComputerSystem | Select-Object Name, Domain, PartOfDomain`

**Expected Results:**

- Computer Name: AC-LAB-PC01
- Domain: corp.aclab.test
- PartOfDomain: True

**Result:** PASS

The Windows 11 workstation successfully joined the Active Directory domain.

**Evidence:** `04-Windows11-Domain-Join.png`

## 4. Employee Domain Login Verification

**Test Objective:** Verify that an Active Directory employee could sign in to the Windows 11 workstation.

**Test Account:** Amsu Magar

**Username:** `CORP\amsu.magar`

**Command Used:**

`whoami`

**Expected Output:**

`corp\amsu.magar`

**Result:** PASS

The employee successfully authenticated using their Active Directory account and accessed the Windows 11 desktop.

**Evidence:** `05-Employee-Login.png`

## 5. Group Policy AutoLock Verification

**Test Objective:** Configure an automatic workstation lock after 10 minutes of inactivity.

**Group Policy:** `GPO-Workstation_AutoLock`

**Configured Setting:** Interactive logon: Machine inactivity limit

**Timeout:** 600 seconds

**Commands Used:**

`gpupdate /force`

`gpresult /scope computer /r`

`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v InactivityTimeoutSecs`

**Expected Registry Value:**

`InactivityTimeoutSecs    REG_DWORD    0x258`

**Result:** PASS

The Group Policy was successfully applied to AC-LAB-PC01. The workstation automatically locked after approximately 10 minutes of inactivity and required employee authentication.

**Evidence:**

- `06-Group-Policy-AutoLock.png`
- `07-GPO-Verification.png`

## 6. Employee Password Reset Verification

**Test Objective:** Simulate an IT Help Desk password-reset request.

**Test Performed:**

- Located the employee account in Active Directory Users and Computers.
- Reset the employee's password.
- Enabled the requirement to change the password at the next logon.
- Signed in to Windows 11 using the temporary password.
- Completed the password-change process.

**Result:** PASS

The employee password-reset workflow was completed successfully.

## 7. Account Lockout Status Verification

**Test Objective:** Check whether an employee's Active Directory account was locked.

**Command Used:**

`Get-ADUser -Identity amsu.magar -Properties LockedOut | Select-Object Name,LockedOut`

**Observed Result:**

`LockedOut: False`

**Result:** PASS

The account lockout status was retrieved successfully. The employee account was not locked, so an unlock operation was not required.

## 8. Shared Folder Access Verification

**Test Objective:** Verify that IT department employees could access a network shared folder.

**Server Folder:**

`C:\LabShares\IT`

**Network Share:**

`\\AC-LAB-DC01\IT-Shared`

**Security Group:**

`GG_IT_Staff`

**Permissions Configured:**

- Read
- Write
- Modify

**Test Performed:**

- Confirmed that the network share existed on Windows Server.
- Verified that GG_IT_Staff had the required folder permissions.
- Opened the shared folder from Windows 11.
- Verified that IT-Test.txt was accessible.

**Command Used:**

`Get-SmbShare -Name "IT-Shared"`

**Result:** PASS

The domain-joined Windows 11 workstation successfully accessed the shared IT folder.

**Evidence:**

- `08-IT-Folder-Permissions.png`
- `09-Network-Share-Test.png`

## 9. PowerShell Automation Verification

**Test Objective:** Automatically retrieve Active Directory employee information and export it to a CSV report.

**Script Name:** `Export-ADUsers.ps1`

**Script Location:**

`C:\LabReports\Export-ADUsers.ps1`

**Command Used:**

`& "C:\LabReports\Export-ADUsers.ps1"`

**Observed Output:**

```text
Employee report generated successfully!
Total employees: 2
Report saved to: C:\LabReports\Employee_Report.csv
```

**Result:** PASS

The PowerShell script executed successfully and exported Active Directory employee information to a CSV report.

**Evidence:**

- `10-PowerShell-Script.png`
- `11-PowerShell-Success.png`
- `12-Employee-CSV.png`

## 10. Final Test Summary

| Test | Status |
|---|---|
| Active Directory domain configuration | PASS |
| DNS and Domain Controller discovery | PASS |
| Windows 11 domain join | PASS |
| Employee domain login | PASS |
| Group Policy deployment | PASS |
| 10-minute automatic screen locking | PASS |
| Employee password reset | PASS |
| Account lockout status check | PASS |
| IT shared-folder access | PASS |
| PowerShell employee report | PASS |

## Conclusion

The Windows Server 2025 Active Directory Help Desk Lab successfully demonstrated core Windows IT administration and troubleshooting tasks.

Through this project, I gained practical experience with:

- Active Directory Domain Services and DNS.
- Windows 11 domain joining and employee authentication.
- Organizational Units, user accounts, and security groups.
- Group Policy configuration and verification.
- Password resets and account-status troubleshooting.
- SMB network sharing and NTFS permissions.
- PowerShell scripting and CSV report generation.

The tests confirmed that the core lab components were functioning and provided hands-on experience relevant to entry-level IT Help Desk, Desktop Support, and Junior System Administrator roles.