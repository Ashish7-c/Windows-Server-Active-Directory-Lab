# Active Directory Lab Setup

## Environment
- Hypervisor: Oracle VirtualBox
- Server: Windows Server 2025
- Workstation: Windows 11 Enterprise Evaluation
- Domain: corp.aclab.test
- Private network: AC-LAB

## Domain Controller
- Computer: AC-LAB-DC01
- IPv4: 192.168.50.10
- Roles: Active Directory Domain Services and DNS

## Windows 11 Workstation
- Computer: AC-LAB-PC01
- IPv4: 192.168.50.20
- DNS Server: 192.168.50.10
- Joined to corp.aclab.test

## Active Directory Organization
- Parent OU: AC-Company
- Department OUs: IT, HR, Finance, Sales
- Computer OU: Workstations

## Configured Services
- Active Directory user and group management
- Group Policy: 600-second inactivity lock
- IT shared folder: \\AC-LAB-DC01\IT-Shared
- PowerShell employee reporting
