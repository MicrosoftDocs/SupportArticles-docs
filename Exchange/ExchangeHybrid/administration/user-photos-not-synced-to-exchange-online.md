---
title: User photos aren't synced to Exchange Online
description: Describes an issue in which a user continues to see the previous Exchange Online profile photo even though you updated the user's photo by using that user's on-premises information.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: minhng
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition 
search.appverid: MET150
---
# User photos aren't synced from the on-premises environment to Exchange Online in a hybrid deployment

_Original KB number:_ &nbsp; 3062745

## Symptoms

You have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365. When you change a Microsoft 365 user's photo by accessing that user's on-premises information, the change isn't synced to Exchange Online. For example, when the user views the photo in Outlook, Outlook on the web (formerly known as Outlook Web App), or Skype for Business Online, the user's previous Exchange Online profile photo is still displayed.

## Cause

Although the `thumbnailPhoto` attribute is synced from the on-premises environment to Azure Active Directory (Azure AD), the following things could cause this problem.

> [!NOTE]
> The `thumbnailPhoto` attribute can store a user photo as large as 100 kilobytes (KB).
>
> - The `thumbnailPhoto` attribute is synced only one time between Azure AD and Exchange Online. Any later changes to the attribute from the on-premises environment are not synced to the Exchange Online mailbox.
> - Exchange Online accepts only a photo that's no larger than 10 KB from Azure AD.

## Resolution

Use the `Set-UserPhoto` cmdlet or Outlook on the web to change the user's photo. These methods enable you to upload a photo that's as large as 500 KB.

### Use the Set-UserPhoto cmdlet (for admins)

To use the `Set-UserPhoto` cmdlet to change a user's photo, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. To do this, follow these steps:

    > [!IMPORTANT]
    > To use the `Set-UserPhoto` cmdlet to its full size capabilities, you have to change the connection URI by appending `?proxyMethod=RPS` to the `ConnectionUri` parameter.

    ```console
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange
    -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS
    -Credential (Get-Credential) -Authentication Basic -AllowRedirection
    ```

    ```console
    Import-PSSession $Session -AllowClobber -WarningAction SilentlyContinue
    -ErrorAction SilentlyContinue
    ```

    For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the [Set-UserPhoto](/powershell/module/exchange/set-userphoto) command to change the user photo.

### Use Outlook on the web

For more information about how to change a user photo in Outlook on the web, see [Update my photo and account information in Outlook Web App](https://support.microsoft.com/office/update-your-photo-and-account-information-in-outlook-web-app-82a97f4b-f87a-4ea0-bab1-d67592924392).

## More information

Admins can use the `Set-UserPhoto` cmdlet to change their own photo without having to change the `ConnectionUri` parameter. However, to change another user's photo, admins must first change the `ConnectionUri` parameter. If the parameter isn't changed, admins receive the following error message when they use the cmdlet to change a user's photo:

> Request return error with following error message:  
The remote server returned an error: (413) Request Entity Too Large...  
\+ CategoryInfo : NotSpecified: (:) [Set-UserPhoto], CmdletProxyException  
\+ FullyQualifiedErrorId : Microsoft.Exchange.Configuration.CmdletProxyException,Microsoft.Exchange.Management.RecipientTasks.SetUserPhoto  
\+ PSComputerName : outlook.office365.com

## References

For more information, see [User contact photos in Lync aren't displayed correctly](/SkypeForBusiness/troubleshoot/online-contacts/user-contact-photos-not-correct).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
