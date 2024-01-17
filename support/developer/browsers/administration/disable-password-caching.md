---
title: How to disable Internet Explorer password caching
description: Provides the steps that you can use to disable Internet Explorer password caching.
ms.date: 02/26/2020
---
# How to disable Internet Explorer password caching

[!INCLUDE [](../../../includes/browsers-important.md)]

When you try to view a Web site that is protected with a password, you are prompted to type your security credentials in the **Enter Network Password** dialog box. If you click to select the **Save this password in your password list** check box in this dialog box, the computer saves your password so that you do not have to type the password again when you try to use the same document. This behavior is known as password caching. However, you may need to disable this feature. This article provides you the steps that you can follow to disable the password caching.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 229940

## More Information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To disable password caching, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
3. On the **Edit** menu, click **New**, and then click **DWORD Value**.
4. Type *DisablePasswordCaching* to name the new registry entry, and then press ENTER.
5. Right-click **DisablePasswordCaching**, and then click **Modify**.
6. Make sure that the **Hexadecimal** option button is selected, type *1* in the **Value data** box, and then click **OK**.
7. Quit Registry Editor.

You can also disable password caching by using the Microsoft Internet Explorer Administration Kit (IEAK) to create an executable file, and then attaching it as an add-in component. When you use this method, Setup adds the `DisablePasswordCaching` entry to the registry during the installation process.

> [!NOTE]
> In some cases, you can create a custom .adm file to modify this registry key, and then import it into the IEAK Wizard.

To re-enable password caching, you can either delete the `DisablePasswordCaching` entry, or change its value to **0**.
