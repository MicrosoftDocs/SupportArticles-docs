---
title: Can't switch between different accounts
description: This article describes a problem that prevents you from switching between different organizational accounts in Visual Studio Online. Resolution requires installation of a Visual Studio update.
ms.date: 04/24/2020
ms.custom: sap:Team Explorer - Version Control\Connecting to TFS
ms.reviewer: acabello
---
# You can't switch between different organizational accounts in Visual Studio Online

This article helps you resolve a problem that prevents you from switching between different organizational accounts in Microsoft Visual Studio Online.

_Original product version:_ &nbsp; Azure DevOps Services Premium, Visual Studio 2013, 2012, 2010  
_Original KB number:_ &nbsp; 2958966

## Symptoms

When you use [Visual Studio Online](https://www.visualstudio.com) accounts that are linked to directory tenants, such as accounts that are created from the Azure Preview Portal, the sign-out function may not work as expected. For example, you can't switch between different organizational accounts to connect to multiple accounts that are linked to directory tenants.

When this problem occurs, you see a flashing blank sign-in dialog box several times. Then, you receive the following error message after you connect to or add a new connection in **Connect to Team Foundation Server** dialog box:

- Error message 1

    > TF31003: Either you have not entered the necessary credentials or your user account does not have permission to connect to the Team Foundation Server

- Error message 2

    > TF31002: Unable to connect to this Team foundation Server

## Resolution: Install Visual Studio 2013 update

To resolve this problem, apply Visual Studio 2013 Update 2 or a later version of the update.

## Workaround 1: Delete browser cookies manually

To work around this problem, delete your browser cookies. To do it, use one of the following methods.

> [!NOTE]
> This workaround will sign you out of all Visual Studio Online accounts and it will delete cookies that customize your browser experience. This might affect your web-browsing experience.

1. Exit Visual Studio.
2. Delete your [Internet Explorer browser cookies, website data, and passwords](https://support.microsoft.com/help/17442).
3. Close all Internet Explorer browser windows.
4. Start Visual Studio, and then reestablish your Visual Studio Online account connection.

## Workaround 2: Delete browser cookies by a shell command

1. Exit Visual Studio and all Internet Explorer browser windows.
2. Locate and then delete the contents of your browser cookie cache. To do it, type the following command in the **Run** dialog box, and then click **OK**:

    ```console
    shell:cookies
    ```

    The default location on Windows 8 and Windows 8.1 is `C:\Users\username\AppData\Local\Microsoft\Windows\INetCookies`.

    The default locations on Windows 8 and Windows 8.1 are as follows:

    - `C:\Users\username\AppData\Roaming\Microsoft\Windows\Cookies`
    - `C:\Users\username\AppData\Roaming \Microsoft\Windows\Cookies\Low`

3. Start Visual Studio, and then reestablish your Visual Studio Online account connection.

## More information

Team Explorer in Visual Studio includes a feature that remembers last-used credentials. Therefore, you don't have to reenter these credentials when you add new Visual Studio Online connections through the **Connect to Team Foundation Server** dialog box in Visual Studio.

When you use multiple Microsoft account credentials that connect to the same or multiple Visual Studio Online accounts, you can use the sign-out function in the **Connect to Team Foundation Server** dialog box to make Visual Studio forget the currently signed-in user. It lets you connect to a Visual Studio Online account that uses a different Microsoft account.
