---
title: Dial-in is unavailable in MMC snap-in
description: Works around an issue where the Dial-in tab is not available in the Active Directory Users and Computers MMC snap-in
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:1st-party-applications, csstroubleshoot
---
# The Dial-in tab is not available in the Active Directory Users and Computers MMC snap-in after you install Remote Server Administration Tools for Windows 7

This article provides workarounds for an issue where the **Dial-in** tab is not available in the Active Directory Users and Computers MMC snap-in.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 975448

## Symptoms

After you install Remote Server Administration Tools for Windows 7 on a computer that is running Windows 7, the **Dial-in** tab is missing in the properties of a user account in the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in.

## Cause

This issue occurs because the RSAT manifest and the installation package do not include the Rasuser.dll and Rtrfiltr.dll modules that are required to load the **Dial-In** tab.

## Workaround

To work around this issue, use one of the following workarounds, as appropriate.

### Workaround 1

On the computer that is running Windows 7, use Remote Desktop Services to connect to a server that is running Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003. Then, start the Active Directory Users and Computers MMC snap-in on the server.

### Workaround 2 (Windows Server 2008)

1. On a server that is running Windows Server 2008, install the **Terminal Services** role, and then install the **Terminal Server** role service to enable the use of RemoteApp Manager.

2. Add Active Directory Users and Computers (DSA.MSC) as a remote application.

3. On the computer that is running Windows 7, access the RemoteApp DSA.MSC.

### Workaround 2 (Windows Server 2008 R2)

1. On the server that is running Windows Server 2008 R2, install the **Remote Desktop Services** role, and then install the **Remote Desktop Session Host** role service to enable use of RemoteApp Manager.

2. Add Active Directory Users and Computers (DSA.MSC) as a remote application.

3. On the computer that is running Windows 7, access the RemoteApp DSA.MSC.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

For more information about Windows Server 2008 Terminal Services, visit the following Microsoft Web site: [https://technet.microsoft.com/library/cc268349.aspx](https://technet.microsoft.com/library/cc268349.aspx)  
For more information about Windows Server 2008 R2 Remote Desktop Services, visit the following Microsoft Web site: [https://technet.microsoft.com/library/dd647502(WS.10).aspx](https://technet.microsoft.com/library/dd647502%28ws.10%29.aspx)
