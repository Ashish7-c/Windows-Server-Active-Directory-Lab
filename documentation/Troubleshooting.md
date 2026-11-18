# Active Directory Help Desk Lab — Troubleshooting

## Overview

During the Windows Server 2025 and Active Directory lab, I encountered several technical issues while configuring domain connectivity, Group Policy, file sharing, and PowerShell automation.

This document records the problems, troubleshooting steps, and results.

## 1. Windows 11 Domain Join Issue

**Problem:** Windows 11 initially failed to join the `corp.aclab.test` domain and displayed an invalid username error.

**Troubleshooting:**

- Verified DNS configuration on the Windows 11 workstation.
- Tested domain resolution using `nslookup corp.aclab.test`.
- Verified domain controller discovery using the Active Directory LDAP SRV record.
- Checked the domain administrator username format: `CORP\Administrator`.
- Reviewed the Windows domain-join log.

**Result:** Successfully joined `AC-LAB-PC01` to the domain and signed in using a domain employee account.

## 2. Group Policy Not Applying

**Problem:** The workstation AutoLock GPO initially did not appear in the applied Group Policy results.

**Troubleshooting:**

- Confirmed that the computer belonged to the Workstations OU.
- Verified that the GPO was linked to the correct OU.
- Checked security filtering and GPO status.
- Found that the computer-side GPO version was initially 0.
- Saved the 600-second inactivity policy again and confirmed that the computer version increased.
- Refreshed Group Policy on Windows 11 using `gpupdate /force`.
- Verified the applied GPO using `gpresult /scope computer /r`.

**Result:** Successfully applied the workstation AutoLock GPO and tested automatic locking after 10 minutes of inactivity.

## 3. Network Shared Folder Troubleshooting

**Problem:** Windows 11 initially could not access the IT department network share.

**Troubleshooting:**

- Verified that the shared folder existed on Windows Server.
- Used `Get-SmbShare -Name "IT-Shared"` on the server.
- Confirmed that the network share pointed to `C:\LabShares\IT`.
- Reviewed the `GG_IT_Staff` security group's folder permissions.
- Tested access through `\\AC-LAB-DC01\IT-Shared` from Windows 11.

**Result:** Successfully accessed the shared folder from the Windows 11 workstation and verified the test file.

## 4. PowerShell Command Errors

**Problem:** Several PowerShell commands initially failed due to syntax mistakes or being executed in Command Prompt.

**Troubleshooting:**

- Switched from CMD to Windows PowerShell.
- Corrected the `-SearchBase` parameter spelling.
- Added missing spaces between command parameters.
- Corrected `Get-SmbShares` to `Get-SmbShare`.
- Ensured commands were executed separately.

**Result:** Successfully queried Active Directory users and exported employee information to CSV.

## 5. VirtualBox Clipboard Problem

**Problem:** Copying commands from the main laptop into Windows Server initially did not work.

**Troubleshooting:**

- Mounted the VirtualBox Guest Additions installation image.
- Installed VirtualBox Guest Additions on Windows Server.
- Enabled the Shared Clipboard feature.
- Tested copying code into Notepad.

**Result:** Enabled clipboard sharing between the host laptop and the Windows Server virtual machine.

## Lessons Learned

This project strengthened my understanding of Active Directory troubleshooting, DNS configuration, Windows authentication, Group Policy processing, network sharing, and PowerShell commands.

It also helped me develop a structured troubleshooting approach: identify the problem, verify configuration, test a solution, and confirm the result.