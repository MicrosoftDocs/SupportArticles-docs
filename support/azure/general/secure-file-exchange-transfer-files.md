---
title: How to securely transfer files to Microsoft Support
description: Provides information to help you fast and secure transfer files with Microsoft Support.
ms.date: 10/10/2024
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-common-issues-support
ms.reviewer: 
---
# How to securely transfer files to Microsoft Support

This article provides information on using Secure File Exchange.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4012140

## What is Secure File Exchange?

When you work with Microsoft Support, it's frequently necessary to transfer files to help the troubleshooting process. We recognize that these files might contain sensitive data and must be handled securely. **Secure File Exchange** was built to enable the fast and secure transfer and storage of files.

The main features of Secure File Exchange are as follows:

- Secure file transfer and storage in the Azure public cloud.
- An ISO 27001 certified system. It has been independently verified as meeting the industry standards for security and protection of data.
- The use of "work or school, or personal Microsoft accounts" for customer authentication.
- Restricted access to your files to only those Microsoft Support Professionals who are actively working on your case.
- Compliance with contractual, regulatory, and certification requirements.
- Automatic permanent deletion of files 90 days after your case is closed, or sooner, at your request.

## Guidance

### How can I access Secure File Exchange?

1. Check your email.

    Look for an email from a Microsoft Support Professional. The subject line will indicate the relevance to your support case and the requirement for a file transfer.
2. Locate the secure link.

   In the email, there's a link to your Secure File Exchange workspace. This link is specific to your support case and shouldn't be shared with others.
3. Access the workspace.
   
   Select the link provided in the email. This will direct you to the Secure File Exchange portal.

### Secure File Exchange "Sign in" and capabilities

Open the Secure File Exchange workspace by using the link provided to in the email from the Microsoft Support Professional. Sign in with your "work or school, or personal Microsoft account." to authenticate your access to the workspace. Signing in allows you to add, download, and delete files.

If you sign in with a "work or school, or personal Microsoft account" that hasn't been added to your service request by the Microsoft Support Professional, you can't add, download, or delete files from the workspace. If you need other accounts added to the Secure File Transfer Workspace, ask your Microsoft Support Professional and they'll add them to the account allowed to interact with the workspace.

#### Authentication (Have you signed in using a "work or school, or personal Microsoft account"?)

- A [personal Microsoft account](https://account.microsoft.com/account) is the combination of an email address and a password that you can use to sign in to all consumer-oriented Microsoft products and cloud services. For example, Outlook (Hotmail), Messenger, OneDrive, MSN, Windows Phone, or Xbox Live. If you use an email address and password to sign in to these or other services, you'll have a Microsoft account. You can also sign up for a new one at any time. Here are some examples of personal Microsoft accounts: username@yahoo.com, username@hotmail.com.
- A work or school Microsoft account is an account created by an organization's administrator. It enables you, as a member of your organization, access to all Microsoft cloud services, such as Microsoft Azure, Microsoft Intune, or Office 365. A work account can take the form of your work email address when an organization federates or synchronizes its Active Directory accounts with Microsoft Entra ID. For example, **username@contoso.com**.

    > [!NOTE]
    > A "work or school Microsoft account" can't also be a "personal Microsoft account" and vice versa.

#### Authorization (Is the "work or school, or personal Microsoft account" that you have signed in with associated with your support case?)

To authorize, your "work or school, or personal Microsoft account" must be associated with your support case. Contact a Microsoft Support Professional if you have any questions about authentication or authorization.

### The Secure File Exchange Experience

Here's an example of Secure File Exchange being used by a customer:

- dmpsetup.log is being uploaded by the customer and has 107 seconds remaining. The upload can also be canceled at any time.
- failovercollection.ps was uploaded by a Microsoft Support Professional (`user@microsoft.com`) for the customer to download.
- Netlogon_netlogon.log was uploaded by the customer (`user@contoso.com`). It's selected and can be downloaded or deleted by the customer.  

    :::image type="content" source="media/secure-file-exchange-transfer-files/secure-file-exchange.png" alt-text="Screenshot shows an example of the Secure File Exchange page.":::

## The physical location of your files when you use Secure File Exchange

All files are physically located in the location of the workspace. The location where a workspace is physically created is as follows.

When you open a support case and the country/region that you specify is:

- In Europe, Secure File Exchange will physically create the workspace in Europe.
- In the United States, Secure File Exchange will physically create the workspace in the United States.
- In any other country/region, Secure File Exchange will find the closest location to the Microsoft Support Professional that's creating the workspace. And it's where the workspace will be physically created.  

## The endpoints that are required to be open on your intranet

|Purpose|Endpoint|
|---|---|
|Secure File Exchange| `https://support.microsoft.com` |
|Personal Microsoft account sign-in| `https://login.live.com` |
|Work or school Microsoft account sign-in| `https://login.microsoftonline.com` |
|Microsoft U.S. Government Cloud services (Azure Gov, Office 365 GCC High and DoD)| `https://dtmffprodclient.usgovtrafficmanager.net`|
|Other| `https://api.dtmnebula.microsoft.com` |
|Other (Microsoft Cloud Deutschland) - For Germany only| `https://dtmbfprodapi.azuretrafficmanager.de`|

  
## What happens when my case is closed?

- The Secure File Exchange workspace link that you received from the Microsoft Support Professional will expire 90 days after it's issued to you, regardless of whether the service request is opened or closed.  If your link has expired and your case is active, ask your Microsoft Support Professional for a new link.
- When the service request is closed by the Microsoft Support Professional, the workspace itself will be inaccessible. If the service request is reopened, and the link hasn't expired, the workspace will be accessible.
- 90 days after the service request is closed, all files in the workspace and the workspace itself will be permanently deleted.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
