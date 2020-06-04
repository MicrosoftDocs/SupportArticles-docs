---
title: Another account is already signed in computer when signing in to Office 2013
description: Discusses an error message that a user receives when he or she tries to sign in to an Office 2013 app by using Office 365 credentials.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office 365
- Office 2013
---

# "Sorry, another account from your organization is already signed in on this computer" in Office 2013

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you try to sign in to an Office 2013 app by using your Office 365 user ID and password, you receive the following error message:  

**Sorry, another account from your organization is already signed in on this computer.**

## Cause

This behavior is expected. It occurs if another account is already signed in to Office 2013 by using a different Office 365 user account within the same organization. 

## Resolution

Sign out of the first account that signed in, then restart that computer. If this solution does not resolve the issue, try the workaround below.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!NOTE]
> This workaround may cause some account settings to be lost.

To work around this behavior, remove the existing user account and all connected services from your Office 2013 profile, and then clear cached credentials that may be on the computer:

### Step 1: Sign out of Office and then sign back in

Sign out of Microsoft Office using any Office product: Word, Excel, PowerPoint, Outlook, etc.
 
   1. Select **File**, and then select **Account**. 
   2. Select **Sign out**. 
   3. Close the Office product and then restart it.
   4. Select **File**, and then select **Account**.
   5. Select **Sign in** and use your credentials to sign back in. 

### Step 2: Remove the user account from your Office 2013 profile
 
1. In the upper-right corner of an Office 2013 app (Word, Excel, PowerPoint), select your name, and then select **Switch Account**.
1. On the **Accounts** screen, select **Sign out**.

   ![Sign out on the Accounts page](./media/another-account-already-signed-in/2750229-4.png)

1. Locate the account that you want to remove, and then select **Sign out**.

### Step 3: Remove connected services from your Office 2013 profile
 
1. Go to **File**, and then select **Account**.
1. Under **Connected Services**, remove all the services for the existing account.
 
   ![Under Connected Services, remove all the services for the existing account.](./media/another-account-already-signed-in/2750229-5.png)

### Step 4: Clear cached credentials on the computer
 
1. Edit the registry to remove cached credentials:

   1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
   1. In Registry Editor, locate the following registry subkey:

      **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity\Identities**

   1. Select the Office account that you want to delete, and then select **Delete**.
   1. In the Identity subkey, locate **Profiles**, right-click the same Office account that you located in **Step 1** of this procedure, and then select **Delete**.
   1. Select **File** and then **Exit** Registry Editor.
    
1. Remove the cached credentials in Credentials Manager:  
   
   1. Select **Start**, then **Windows System**, then open the **Control Panel** and select **Credential Manager**.

      > [!NOTE]
      > You may have to use the search field in the Control Panel to find the Credential Manager.

   1. Under the **Windows Credentials** tab, locate the account that you want to remove and then select **Remove**.

      > [!NOTE]
      > In Windows 7, this is listed as **Generic Credentials**. 

      ![Remove Windows Credentials](./media/another-account-already-signed-in/2750229-6.png)

1. Log off, and then log back in to the computer.

## More information

For more information, see [Recommendations on resolving common sign-in issues](https://docs.microsoft.com/office365/troubleshoot/administration/disabling-adal-wam-not-recommended#recommendations-on-resolving-common-sign-in-issues).

In Office 2013 apps, you can access Office 365 content in SharePoint Online by providing your Office 365 user ID and password. If you have multiple Office 365 user IDs from different organizations, you can access content from the SharePoint Online deployments of each organization.

However, Office 2013 only supports one Office 365 user sign-in from each tenant or organization per session.

Office 2013 makes a best effort to prevent a second user from signing in when another user from the same organization is already signed in. However, there may be cases in which this scenario is not detected and the Office 2013 user interface may show that another user is successfully signed in. In this case, the second user cannot access his or her own content. All Office 365 content that he or she tries to open will be performed by using the first user's credentials.

Be aware that Office 2013 respects the permissions of all documents and SharePoint Online libraries. That is, if the first user doesn't have access to a document that the second user has access to, and the second user (who believes they are signed in) attempts to open that document, the document will not open because Office tries to open the document as the first user.

To fix this scenario, the signed-in user should sign out of Office 2013, and then restart his or her computer. Doing this makes sure that a clean state is present when the other user tries to sign in again.

If restarting the computer does not resolve the issue, then adjusting the registry is the recommended solution.  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).