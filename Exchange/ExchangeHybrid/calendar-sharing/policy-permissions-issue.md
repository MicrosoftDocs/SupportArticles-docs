---
title: Policy does not allow granting permissions at this level when share calendar
description: Describes an error that occurs when users try to share their calendar to a cross-premises user.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition 
---

# "Policy does not allow granting permissions at this level to one or more of the recipient(s)" error when user tries to share calendar

## Problem 

An Office 365 user tries to share their calendar with an on-premises user or an external user. Or, an on-premises user tries to share their calendar with an Office 365 user or an external user. In either scenario, the user who tries to share their calendar to the cross-premises user receives the following error message:

**Policy does not allow granting permissions at this level to one or more of the recipient(s). Please select another permission level and send the sharing invite again.**

## Cause 

This problem occurs if the sharing policy doesn't allow the user to share the level of detail that the user set in the sharing invitation. 

## Solution 

To resolve this problem, follow these steps:

1. Do one of the following, as appropriate for your situation:
   - Connect to Exchange Online by using Remote PowerShell. For more information, see [Connect to Exchange Online using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).   
   - On the on-premises server, open the Exchange Management Shell.   
   
2. Determine the sharing policy that's assigned to the user. To do this, run the following command and note the policy returned:

    ```powershell
    Get-Mailbox User1 | fl *sharing*
    ```
1. Update the sharing policy for the user. To do this, follow these steps:
   1. Open the Exchange admin center.   
   2. Click **Organization**, and then double-click the policy that's assigned to the user under **Individual Sharing**. This is the policy that was returned in step 2.   
   3. On the Sharing Rule page, select the calendar sharing level that you want to allow under **Specify what information you want to share**, and then click **Save**.   
   
## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).