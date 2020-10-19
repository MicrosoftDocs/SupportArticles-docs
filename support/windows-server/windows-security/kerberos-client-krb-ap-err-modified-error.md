---
title: Kerberos client receives KRB_AP_ERR_MODIFIED error
description: Resolve an error (The kerberos client received a KRB_AP_ERR_MODIFIED error from the server) that occurs when you access to NLB virtual IP/NLB Virtual Name.  
ms.date: 10/13/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Kerberos authentication
ms.technology: WindowsSecurity
---
# The kerberos client received a KRB_AP_ERR_MODIFIED error from the server

The article helps you to resolve the error: The kerberos client received a KRB_AP_ERR_MODIFIED error from the server.  

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 558115

## Symptoms

During access to NLB virtual IP/NLB Virtual Name, the user may prompt to a username and password, and the following error may add to the local system event log:

> Event ID: 4  
Source: Kerbeors  
Type: Error
>
> "The kerberos client received a KRB_AP_ERR_MODIFIED error from the server host/myserver.domain.com. This indicates that the password used to encrypt the kerberos service ticket is different than that on the target server. Commonly, this is due to identically named machine accounts in the target realm (domain.com), and the client realm. Please contact your system administrator."

## Cause

During access to the IIS 6 web site that support Windows Integrated Authentication, the following issues may occur:

1. Mismatch DNS name resolution. The issue is common in a NLB environment that uses multiple IPs or network adapters.
1. The user doesn't have a Local NTFS access permission.
1. The Web Site is using Application Pool with a poor permission setting.

## Resolution

To resolve the error issue, consider to implement the following tests:

1. Verify that the IIS has been set up with correct NTFS settings.

    Integrated Windows Authentication (IIS 6.0)

2. Verify that each cluster node has been set up with correct DNS settings.

3. Verify that the node has been set up with correct Application Pool settings:

    Configuring Application Pool Identity with IIS 6.0 (IIS 6.0)

4. Verify that internet explorer has been set up with a correct security setting.

## More information

Authentication and Access Control Diagnostics 1.0 (x86)

Internet Information Services Diagnostic Tools

### Community solutions content disclaimer

Microsoft corporation and its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained here. All such information and related graphics are provided as is without warranty of any kind. Microsoft and its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained here, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
