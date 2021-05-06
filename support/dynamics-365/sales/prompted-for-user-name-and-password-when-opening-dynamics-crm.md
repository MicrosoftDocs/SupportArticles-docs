---
title: Prompted for credentials when opening CRM for Outlook
description: Provides methods for resolving an issue where you are prompted for your user name and password every time that you open Microsoft Dynamics CRM or Microsoft Dynamics CRM client for Microsoft Office Outlook.
ms.reviewer: dmartens, tlemar
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# You are prompted for user name and password when opening Microsoft Dynamics CRM or Dynamics CRM client for Outlook

This article provides resolutions for the issue that you're prompted for credentials when opening Microsoft Dynamics CRM or Microsoft Dynamics CRM client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 892666

## Symptoms

When you open Microsoft Dynamics CRM or Microsoft Dynamics CRM for Microsoft Office Outlook, you are prompted for your user name and password.

## Cause

This issue occurs when one of the following conditions is true:

- The **Prompt for user name and password** option is enabled in Microsoft Internet Explorer.
- Your computer is running, and the user name and the password for the Microsoft Dynamics CRM Web site is stored on your computer.
- Members of the Domain Users group do not have access to the C:\Windows\Temp folder on the Microsoft Dynamics CRM server.
- The Microsoft Dynamics CRM Web site is not added to the list of local intranet sites in Internet Explorer.
- The **Integrated Windows Authentication** check box is not selected in Internet Explorer.
- You are using a proxy server for the LAN settings in Internet Explorer.

## Resolution 1 - Modify the security settings in Internet Explorer

To modify the security settings in Internet Explorer, follow these steps:

1. Start Internet Explorer.
2. Select **Tools**, select **Internet Options**, and then select the **Security** tab.
3. If your computer is connected to the Internet, select **Internet**, and then select **Custom Level**.

   If your computer is connected only to a local intranet, select **Local Intranet**, and then select **Custom Level**.
4. In the **Security Settings** dialog box, make sure that **Automatic logon with current username and password** is enabled under **User Authentication**.
5. Select **OK** two times.

## Resolution 2 - Delete the stored user name and password

If your computer is running Microsoft Windows XP or Microsoft Windows Server 2003, follow these steps to delete the stored user name and password for the Microsoft Dynamics CRM Web site:

1. Select **Start**, point to **Settings**, point to **Control Panel**, double-click **User Accounts**, and then select the **Advanced** tab.
2. Select **Manage Passwords**.
3. Delete any stored usernames or passwords that reference the Microsoft CRM server.

If your computer is running another version of Windows, follow these steps:

1. Start Internet Explorer.
2. Select **Tools**, and then select **Internet Options**.
3. Select the **Content** tab, select **AutoComplete**, select **Clear Passwords**, and then select **OK**.

## Resolution 3 - Grant access to members of the Domain Users group

To grant members of the Domain Users group access to the C:\Windows\Temp folder on the Microsoft Dynamics CRM server, follow these steps:

1. In Windows Explorer, locate the Temp folder in the Windows folder or in the Winnt folder on the Microsoft Dynamics CRM server.
2. Right-click the Temp folder, select **Properties**, and then select the **Security** tab.
3. Select **Add** to open the **Select Users, Computers, or Groups** dialog box.
4. In the **Look in** list, select **Select the Domain**.
5. Select the **Domain Users** group, select **Add**, and then select **OK**.
6. Make sure that the check boxes for the following permissions are selected, and then select **OK**:
   - Read & Execute
   - List Folder Contents
   - Read

## Resolution 4 - Add the Microsoft CRM Web site to the list of local intranet sites in Internet Explorer

1. Start Internet Explorer.
2. Select **Tools**, select **Internet Options**, and then select the **Security** tab.
3. Select **Local Intranet**, select **Sites**, and then select **Advanced**.
4. Add the Microsoft Dynamics CRM server name, the Microsoft Dynamics CRM server fully qualified domain name (FQDN), and any host header or alias names that you created for the Microsoft Dynamics CRM URL.
5. Select **Close**.

## Resolution 5 - Enable Integrated Windows Authentication in Internet Explorer

1. Start Internet Explorer.
2. Select **Tools**, select **Internet Options**, and then select the **Advanced** tab.
3. Verify that the **Enable Integrated Windows Authentication** check box is selected.

## Resolution 6 - Set the proxy server setting in Internet Explorer

1. Start Internet Explorer.
2. Select **Tools**, select **Internet Options**, and then select the **Connections** tab.
3. Select **LAN settings**, clear the **Use a proxy server for your LAN** check box, and then select **OK**.
