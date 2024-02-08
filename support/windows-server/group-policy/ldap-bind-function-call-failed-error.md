---
title: LDAP Bind function call failed error when updating Group Policy settings
description: Helps resolve the error LDAP Bind function call failed when updating Group Policy settings.
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.date: 11/23/2023
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, dennhu, pkalamkar, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
ms.subservice: group-policy
---
# "LDAP Bind function call failed" error when updating Group Policy settings

This article helps resolve the error "LDAP Bind function call failed" that occurs when updating Group Policy settings.

When you use the [gpupdate](/windows-server/administration/windows-commands/gpupdate) command to update Group Policy settings, you receive the following error:

```output
C:\Windows\system32>gpupdate
Updating policy...
Computer policy could not be updated successfully. The following errors were encountered:
The processing of Group Policy failed because of lack of network connectivity to a domain controller. This may be a transient condition. A success message would be generated once the machine gets connected to the domain controller and Group Policy has successfully processed. If you do not see a success message for several hours, then contact your administrator.
User Policy could not be updated successfully. The following errors were encountered: The processing of Group Policy failed. Windows could not authenticate the Active Directory service on a domain controller. (LDAP Bind function call failed). Look in the details tab for error code and description.

To diagnose the failure, review the event log or run GPRESULT /H GPReport.html from the command line to access information about Group Policy results.
```

On the domain controller, the default principles are missing for the `SeNetworkLogonRight` user right associated with the **Access this computer from the network** Group Policy setting. That policy is under **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment** in the Local Group Policy Editor. 

In this scenario, the default domain policy is enforced over the default domain controller policy. Then, the default domain policy shows an incorrect user right assignment for the **Access this computer from the network** Group Policy setting.

To resolve this issue, make sure that the appropriate principles are added and that the settings are effective on the domain controller, as described in [Access this computer from the network - security policy setting](/windows/security/threat-protection/security-policy-settings/access-this-computer-from-the-network). Then, restart the domain controller.
