---
title: Access is denied when you connect to Exchange Online with Windows PowerShell
description: Describes an issue in which an incorrect user name or password is entered or the user tries to sign in to the service by using an account that doesn't have access to Exchange Online. Provides a resolution.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# "Access is denied" error when you connect to Exchange Online by using remote Windows PowerShell

## Problem 

When you try to connect to Microsoft Exchange Online by using remote Windows PowerShell, you receive the following error message: 

```asciidoc
[outlook.office365.com] Connecting to remote server failed with the following error message: Access is
denied. For more information, see the about_Remote_Troubleshooting Help topic.

+ CategoryInfo : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [].
PSRemotingTransportException

+ FullyQualifiedErrorId : PSSessionOpenedFailed

Import-PSSession : Cannot validate argument on parameter 'Session'. The argument is null.
Supply a non-null argument and try the command again.

At D:\Users\Connect.ps1:7 char:21

+ Import-PSSession < < < < $Session

+ CategoryInfo : Invalid Data: (:) [Import-PSSession], ParameterBindingValidationException

+ FullyQualifiedErrorId :
ParameterArgumentValidationError,Microsoft.PowerShell.Commands.ImportPSSessionCommand
```

## Cause 

This issue occurs for one of the following reasons: 

- You enter an incorrect user name or password.   
- You try to sign in to the service by using an account that doesn't have access to Exchange Online.   

## Solution 

To resolve this issue, use the Exchange admin center in Office 365 to add the user as a member of the administrator role group. To do this, follow these steps:

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.    
2. Click **Admin**, and then click **Exchange**.    
3. Click **permissions**, and then click  **admin roles**.    
4. Double-click the role group to which you want to add the user. For example, if you want the user to have full access that includes Windows PowerShell, double-click **Organization Management**.    
5. To add the user to the list, click **Add** (![Add icon](https://support.microsoft.com/Library/Images/2982855.jpg)) under **Members**.   
6. Click **Save**.   

## More information

For more information about how to connect to Exchange Online by using remote PowerShell, go to [Connect to Exchange Online using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.150%29.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).