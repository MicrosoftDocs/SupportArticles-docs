---
title: Cannot change home page in Internet Explorer
description: Provides a manual fix for home page problems in Internet Explorer.
ms.date: 03/17/2020
---
# Cannot change your home page in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the steps that you can follow to solve the issue that you cannot change your home page in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2493729

## Symptoms

When you use Internet Explorer, you may experience any of the following symptoms:

- Your Internet Explorer home page has been changed to a different website than the one that you selected.
- You cannot change your home page selection to the website that you want.
- You reset your home page to the website that you want in **Internet Options**. However, after you restart the computer, your home page selection has again been changed to a different website.

## Cause

This problem can occur for several reasons. Your computer may be infected with a virus, malicious code may have been run on the computer, or you may have installed a third-party software that changed your home page setting.

Before you use the method that is described in this article, make sure that your computer has not been infected with a virus or malicious code by running an antivirus program. For more information, see [Intelligent security](https://www.microsoft.com/security?rtc=1).

## Resolution

To fix this problem manually, follow these steps:

1. Click **Start**, in the **Start Search** box, type *regedit*.

2. In the **Programs** list, click **Regedit.exe**.

   - If you are prompted for an administrator password or confirmation, type the password or click **Continue**.

3. Locate and then right-click the following registry subkey:  
    `HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\`

4. Click **Delete**.

5. Locate and then check the following three registry subkeys, and then change the values of the **Default_Page_URL** and **Start Page** entry to your desired website.

   - `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main`
   - `HKEY_ LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main`
   - `HKEY_USERS\Default\Software\Microsoft\Internet Explorer\Main`

6. Restart the computer.

## More information

For more information about how to change your browser home page in Microsoft Edge, see [Change your browser home page](https://support.microsoft.com/help/4027577).
