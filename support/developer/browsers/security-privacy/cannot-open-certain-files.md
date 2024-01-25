---
title: Cannot open certain files in Windows 7
description: Fixes a problem in which you receive an error message when you try to open .exe files by using Internet Explorer in Windows 7.
ms.date: 03/23/2020
ms.reviewer: Joel
---
# "Your Internet security settings prevented one or more files from being opened" error when opening files

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the methods for you to solve the error message that occurs when you open files by using Internet Explorer in Windows 7.

_Original product version:_ &nbsp; Internet Explorer, Windows 7  
_Original KB number:_ &nbsp; 2588679

## Symptoms

When you try to open a file by using Internet Explorer in Windows 7, you receive the following error message:

> These files can't be opened.  
> Your Internet security settings prevented one or more files from being opened.

:::image type="content" source="media/cannot-open-certain-files/file-cannot-be-opened-error.png" alt-text="Screenshot of the error message dialog box." border="false":::

## Cause

This issue may occur because the following conditions are true:

- The file type that you are trying to open is considered unsafe.
- The **Launching applications and unsafe file** security setting is set to **Disable** for the zone that is associated with where the file originated.

## Resolution 1: Reset Internet Explorer security zone settings to their default level

To reset Internet Explorer security zone settings to their default level, follow these steps:

1. Start Internet Explorer.
2. Click **Tool**, and then click **Internet options**.
3. Click the **Security** tab.
4. Click **Reset all zones to default level**, and then click **OK**.

## Resolution 2: Reset Internet Explorer settings

> [!NOTE]
> The steps in this article may not fully resolve the issue. For example, if the current Internet Explorer settings are being enforced by a Group Policy object (GPO), these steps may not resolve the issue. If you want further assistance in resolving the problem that is described in this article, contact Microsoft Customer Support.

## More information

When files are downloaded to a local computer that is running Windows XP Service Pack 2 or a later version, a security zone identifier is stored together with the file properties. This identifier corresponds to the Internet Explorer security zone for where the file was obtained.

When a downloaded file is identified as an unsafe file type, the **Launching applications and unsafe file** option for the corresponding security zone is queried for one of three options: **Enable**, **Prompt**, or **Disable**. The dialog that is mentioned in the Symptoms section will be displayed when the **Launching applications and unsafe file** option is set to **Disabled**.

For more information about unsafe file types, see:

- [Information about the Unsafe File List in Internet Explorer 6, 7, or 8](https://support.microsoft.com/help/291369)
- [An overview of unsafe file types in Microsoft products](https://support.microsoft.com/help/925330)

For more information about the process that is used to apply zone identifiers to files, see [Information about the Attachment Manager in Microsoft Windows](https://support.microsoft.com/help/883260).

For more information about the Internet Explorer security zones, see [Internet Explorer security zones registry entries for advanced users](https://support.microsoft.com/help/182569).
