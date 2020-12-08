---
title: How to track users logon/logoff
description: 
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to track users logon/logoff

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise Edition for Itanium-based Systems, Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)  
_Original KB number:_ &nbsp; 556015

## Author:

Yuval Sinay MVP

## COMMUNITY SOLUTIONS CONTENT DISCLAIMER

MICROSOFT CORPORATION AND/OR ITS RESPECTIVE SUPPLIERS MAKE NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, OR ACCURACY OF THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN. ALL SUCH INFORMATION AND RELATED GRAPHICS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH REGARD TO THIS INFORMATION AND RELATED GRAPHICS, INCLUDING ALL IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, WORKMANLIKE EFFORT, TITLE AND NON-INFRINGEMENT. YOU SPECIFICALLY AGREE THAT IN NO EVENT SHALL MICROSOFT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA OR PROFITS, ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OF OR INABILITY TO USE THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, EVEN IF MICROSOFT OR ANY OF ITS SUPPLIERS HAS BEEN ADVISED OF THE POSSIBILITY OF DAMAGES.

## SUMMARY

*The following article will help you to track users logon/logoff*  

## Tips

****  
 **Option 1:**  

1. Enable Auditing on the domain level by using Group Policy:

** Computer Configuration/Windows Settings/Security Settings/Local Policies/Audit Policy**  

There are two types of auditing that address logging on, they are **Audit Logon Events** and **Audit Account Logon Events**.

Audit "logon events" records logons on the PC(s) targeted by the policy and the results appear in the Security Log on that PC(s).

Audit "Account Logon" Events tracks logons to the domain, and the results appear in the Security Log on domain controllers only

2. Create a logon script on the required domain/OU/user account with the following content:

echo %date%,%time%,%computername%,%username%,%sessionname%,%logonserver% >> 

3. Create a logoff script on the required domain/OU/user account with the following content:

echo %date%,%time%,%computername%,%username%,%sessionname%,%logonserver% >> 

**Note** : Please be aware that unauthorized users can change this scripts, due the requirement that

the SHARENAME$ will be writeable by users.

**Option 2:**  

Use WMI/ADSI to query each domain controller for logon/logoff events.
