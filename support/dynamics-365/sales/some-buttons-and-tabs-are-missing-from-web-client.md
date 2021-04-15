---
title: Some buttons and tabs missing from the Web client
description: Describes an issue that occurs because the Microsoft Dynamics CRM Web client and the Microsoft Dynamics CRM client for Outlook both use the same cookie.
ms.reviewer: jstrand
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Some buttons and tabs are missing from the Microsoft Dynamics CRM Web client

This article provides a resolution for the issue that some buttons or tabs are missing when you start the Microsoft Dynamics CRM Web client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 910050

## Symptoms

Some buttons and tabs are missing from the Microsoft Dynamics CRM Web client. This issue occurs when the Microsoft Dynamics CRM desktop client for Microsoft Office Outlook is running on the computer, and you start the Microsoft Dynamics CRM Web client.

For example, one or more of the following buttons or tabs are missing when you start the Microsoft Dynamics CRM Web client:

- The **Delete** button in the **Quotes** dialog box.
- The **Send Direct E-mail** button in the **Accounts** dialog box.
- The **Send Direct E-mail** button in the **Contacts** dialog box.
- The **Settings** tab in the Navigation Pane.
- The **Calendar** link under **Workplace**.

## Cause

This issue occurs because the cookie from the Microsoft Dynamics CRM client for Outlook is present when you start the Microsoft Dynamics CRM Web client. This cookie is created when you start the Microsoft Dynamics CRM client for Outlook. If this cookie is present, the Microsoft Dynamics CRM Web client uses the Web pages of the Microsoft Dynamics CRM client for Outlook.

> [!NOTE]
> The cookie is deleted when you exit the Microsoft Dynamics CRM client for Outlook.

## Resolution

To resolve this issue, delete the Microsoft Internet Explorer cache. To do this, follow these steps:

1. Exit the Microsoft Dynamics CRM Web client and the Microsoft Dynamics CRM client for Outlook.
2. Start Microsoft Internet Explorer.
3. Select **Tools**, and then select **Internet Options**.
4. Select **Delete Cookies**, and then select **OK**.
5. Select **Delete Files**, and then select **OK**.

To prevent this issue, exit the Microsoft Dynamics CRM client for Outlook before you start the Microsoft Dynamics CRM Web client or open the Microsoft Dynamics CRM Web client before you start the Microsoft Dynamics CRM client for Outlook.

## Workaround

If you want to use the Microsoft Dynamics CRM Web client and the Microsoft Dynamics CRM client for Outlook at the same time, use one of the following methods.

### Method 1

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Sign in to the Microsoft Dynamics CRM client for Outlook.
2. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
3. In Registry Editor, locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`

4. Double-click **WebAppUrl**.
5. In the **Edit String** dialog box, change the value that is in the **Value data** field. The original value is the Microsoft Dynamics CRM server name and port number. Change this value to an IP address. For example, the IP address may be `https://192.169.1.1:5555`.
6. Double-click **PlatformRoot**.
7. In the **Edit String** dialog box, change the value that is in the **Value data** field. The original value is the Microsoft Dynamics CRM server name and port number. Change this value to a value that includes an IP address. For example, the new value may be `https://192.169.1.1:5555/MSCRMServices`.
8. Double-click **ServerUrl**.
9. In the **Edit String** dialog box, change the value in the **Value data** field. The original value is the Microsoft Dynamics CRM server name and port number. Change this value to an IP address. For example, the IP address may be `https://192.169.1.1:5555`.

### Method 2

Use another URL for Microsoft Dynamics CRM. To do this, add another host header name to the Microsoft Dynamics CRM Web page, and then add this name to the Domain Name System (DNS).
