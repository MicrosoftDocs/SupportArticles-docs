---
title: The supplied password does not match this encryption key's password error and ADMT 3.1 PES installation fails
description: Resolves an issue where error (The supplied password does not match this encryption key's password) occurs when you configure the Password Export Server (PES) service on Active Directory Migration Tool version 3.1.
ms.date: 05/31/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, tonnyp
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
ms.technology: windows-server-active-directory
---
# ADMT 3.1 PES installation fails with error: The supplied password does not match this encryption key's password

This article helps resolve an issue where an "The supplied password does not match this encryption key's password" error occurs when you configure the Password Export Server (PES) service on Active Directory Migration Tool version 3.1.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2004090

## Symptoms

Configuring the Password Export Server (PES) service on Active Directory Migration Tool version 3.1 on the source domain PDC Emulator role holder using the `ADMT KEY` command shown below fails with the following on-screen error:

Command-line syntax:

ADMT KEY /OPTION:CREATE /SOURCEDOMAIN:\<ADMT source domain> /KEYFILE:x:\\\<path>\\\<filename>.pes /PWD:*

On-screen error:  
> Dialog Title text: Invalid Password!  
> Dialog message text:  
>
>The supplied password does not match this encryption key's password. ADMT's Password Migration Filter DLL will not install without a valid encryption key.

## Cause

The supplied password was correct, but Windows Installer (*msiexec.exe*) failed to open a handle to the policy object on the domain controller for saving the password that will be used by the PES service. The failure indicates that the user account didn't have the required permission.  

 The user who installs the PES service must be a member of the domain's built-in Administrators group.  

 In addition, if the user account isn't a member of the built-in Administrators account, and User Account Control (UAC) is enabled on the domain controller, the user runs with least user privileges after logon. To access the policy object on the domain controller for installing the PES service, the user must launch the *Pwdmig.msi* setup file with full privileges.  

## Resolution

Ensure the user account who installs the PES service is a member of the domain's built-in Administrators group by running the `whoami /groups` command, and then run the *Pwdmig.msi* setup file in an elevated command prompt window launched with the **Run as administrator** option.

Alternatively, you can launch an elevated command prompt window, change the directory to the one where you downloaded the PES installer, and then run the `msiexec /i pwdmig.msi` command.

## More information

If you see that the output of the command `whoami /groups` looks like the following, it means the user logged in with least user privileges. Although they're a member of the built-in Administrators group, they don't have permissions to perform administrative tasks with this token.  

`Whoami /groups` output:  

| Group Name| Type| SID| Attributes |
|---|---|---|---|
| ==========| ==========| ==========| ========== |
| Everyone| Well-known group| S-1-1-0| Mandatory group, Enabled by default, Enabled group |
| BUILTIN\Administrators| Alias| S-1-5-32-544| Group used for deny only |
| BUILTIN\Users| Alias| S-1-5-32-545| Mandatory group, Enabled by default, Enabled group |
| ....||| |
