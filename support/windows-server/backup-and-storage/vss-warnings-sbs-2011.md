---
title: VSS Warnings in Application Event log
description: Works around an issue where you get VSS warnings in the Application Event log of Windows Small Business Server 2011 Standard.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# You may get VSS warnings in the Application Event log of SBS 2011 Standard

This article provides a workaround for an issue where you get VSS warnings in the Application Event log of Microsoft Windows Small Business Server 2011 Standard.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2537096

## Symptoms

In Small Business Server 2011 Standard, you may see warnings in the application event log that's similar to the following:

> Log Name: Application  
Source: VSS  
Date: *\<DateTime>*  
Event ID: 8230  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: CONTOSOSERVER.contoso.local  
Description:  
Volume Shadow Copy Service error: Failed resolving account spsearch with status 1376. Check connection to domain controller and VssAccessControl registry key.

The warnings may also reference the spfarm account.

## Cause

SBS 2011 Standard Edition installs SharePoint 2010 Foundation in SharePoint farm mode. The accounts SharePoint farm and SharePoint search are used as service accounts for some of the SharePoint services. In order to be able to utilize the VSS writers, the accounts must be granted access to VSS. The accounts are added by SBS to the **VssAccessControl** registry key but the VSS service fails to locate the accounts. You can ignore the warnings. The warnings don't affect the operation of VSS. If you wish to remove the warnings, you can use the steps in the resolution section.

## Workaround

Use the following steps to work around the issue.

1. In Active Directory Users and Computers, create a Domain Local Security Group named *VSSRegistryGroup*.

2. Add SPFARM and SPSEARCH accounts to the VSSRegistryGroup Group.

3. Run regedit.

    > [!IMPORTANT]
    > This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

4. Go to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VSS\VssAccessControl`.

5. Add DWORD value of DOMAIN\vssregistrygroup where domain is the netbios domainname (for example, CONTOSO\vssregistrygroup. The Domain name must be in all caps) set the value to 1

6. Remove values for domain\spsearch and domain\spfarm.

7. Go to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VSS\diag`.

8. Right-click **diag** and go permissions, click **Advanced** and add VSSRegistrygroup group with Full Control.

9. Remove spsearch and spfarm accounts from the list of permissions.

10. Reboot the server.

## More information

If the VSSAccessControl registry key does not contain the exact right accounts, the service Sharepoint 2011 VSS Writer will fail to start and the following error will be logged in the application event log:

> Log Name: Application  
Source: VSS  
Date: *\<DateTime>*  
Event ID: 8213  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: CONTOSOSERVER.contoso.local  
Description:  
Volume Shadow Copy Service error: The process that hosts the writer with name SharePoint Services Writer and ID {da452614-4858-5e53-a512-38aab25c61ad} does not run under a user with sufficient access rights. Consider running this process under a local account which is either Local System, Administrator, Network Service, or Local Service.
>
> Operation: Initializing Writer
>
> Context:  
> Writer Class Id: {da452614-4858-5e53-a512-38aab25c61ad}  
 Writer Name: SharePoint Services Writer
