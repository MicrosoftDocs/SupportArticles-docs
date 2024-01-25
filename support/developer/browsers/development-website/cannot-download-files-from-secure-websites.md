---
title: Cannot download files from secure websites
description: Resolve issues with error message Internet Explorer Cannot Download or Filename couldn't be downloaded when using Internet Explorer 9 and later versions. This can happen on bank websites when downloading .PDF and other forms of tax files.
ms.date: 04/21/2020
---
# "Couldn't be downloaded" error when downloading files from secure websites in Internet Explorer 9 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving the **Couldn't be downloaded** error that occurs when you try to download files by using Internet Explorer 9 or a later version.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2549423

## Symptoms

You cannot download files or view files from a website when you connect to the site over HTTPS (secure sites) by using Internet Explorer 9 or a later version. For example, you visit a secure website such as a bank or other financial institution and try to download or view a PDF file. The file does not appear in Internet Explorer and you may see an error message similar to the following:

Error message 1

> Internet Explorer Cannot Download

Error message 2

> \<Filename\> couldn't be downloaded

This problem occurs if the **Do not save encrypted pages to disk** option in Internet Explorer is selected.

> [!NOTE]
> For Internet Explorer 8, see ['Internet Explorer Cannot Download' error message when you use an HTTPS URL to open an office document or PDF file](https://support.microsoft.com/help/812935).

## Cause

To download files, Internet Explorer must create a cache or temporary file. In Internet Explorer 9 or a later version, if the file is delivered over HTTPS, and any response headers are set to prevent caching, and if the **Do not save encrypted pages to disk** option is set, a cache file is not created. Therefore, the download fails.

## Resolution - Method 1

To fix this issue, first try method 1. If method 1 fails, go to method 2.

1. On the **Tools** menu in Internet Explorer 9 or a later version, click **Internet Options**, and then click the **Advanced** tab.
1. Click to clear the check mark from the **Do not save encrypted pages to disk** check box in the **Security** area, and then click **OK**. (This is the default Internet Explorer setting.)

:::image type="content" source="media/cannot-download-files-from-secure-websites/do-not-save-encrypted-pages-to-disk.png" alt-text="Screenshot of the Internet Options window. Under Security, Do not save encrypted pages to disk check box is cleared." border="false":::

## Resolution - Method 2

1. Start Registry Editor.
2. For a per-user setting, locate the following registry key:  
    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`

   For a per-computer setting, locate the following registry key:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`

3. On the **Edit** menu, click **Add Value**, and then add the following value:  
    `BypassSSLNoCacheCheck`=Dword:**00000001**

4. Exit Registry Editor.
