---
title: Fail to seize RID Master role with Ntdsutil
description: Fixes an error that occurs when you seize the relative ID (RID) Master role with the Ntdsutil tool to a different domain controller.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-fsmo, csstroubleshoot
ms.subservice: active-directory
---
# Error Attempting to Seize RID Master Role with Ntdsutil

This article provides help to fix an error that occurs when you seize the relative ID (RID) Master role with the Ntdsutil tool to a different domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2001165

## Symptoms

Assume the following scenario. The server that holds the RID operations master role is no longer accessible and must be rebuilt. You attempt to seize the RID Master role with the Ntdsutil tool to a different domain controller but you receive the following error:

> Attempting safe transfer of RID FSMO before seizure.  
ldap_modify_sW error 0x34(52 (Unavailable).  
Ldap extended error message is 000020AF: SvcErr: DSID-0321093D, problem 5002 (UNAVAILABLE), data 8  
Win32 error returned is 0x20af (The requested FSMO operation failed. The current FSMO holder could not be contacted.)  
Depending on the error code this may indicate a connection, ldap, or role transfer error.  
Transfer of RID FSMO failed, proceeding with seizure ...  
Search failed to find any Domain Controllers  

## Cause

The **fSMORoleOwner** attribute of the **RID Manager$** object in Active Directory is invalid. For example, the following value would result in this error:

> CN=NTDS Settings DEL:a586a105-5a9c-4b2f-8289-bc5b43841ac8,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com

## Resolution

To resolve this issue, use the AdsiEdit tool to update the **fSMORoleOwner** attribute of the **Rid Manager$** object in Active Directory.  

1. Open AdsiEdit (AdsiEdit.msc).

2. Expand **Domain**, then select **CN=System**.

3. With **CN=System** selected in the left pane, right-click **CN=RID Manager$** and select **Properties**.

4. The **fSMORoleOwner** attribute should correspond to the old RID Master. For example, if DC01 was the old RID Master (the server that is no longer available), the **fSMORoleOwner** attribute would be:

    > CN=NTDS Settings,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com

    An example of an invalid value for the **fSMORoleOwner** attribute that may result in an error when attempting to seize the role would be:

    > CN=NTDS Settings DEL:a586a105-5a9c-4b2f-8289-bc5b43841ac8,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com

5. Change the **fSMORoleOwner** attribute value to reflect the domain controller that you want to be the RID Master. For example if DC01 is the failed domain controller, and DC02 is the domain controller to which you want to seize the RID Master role, you would change the attribute to reflect that DC02 will be the new RID Master.

    > CN=NTDS Settings,CN=DC02,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com

6. Changing the **fSMORoleOwner** attribute accomplishes the same thing as seizing the role with Ntdsutil. Therefore after changing the attribute manually you do not need to use Ntdsutil to seize the role.
