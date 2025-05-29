---
title: The operation has timed out when connecting to OData by using SSIS in Project Online
description: Works around an issue in which the operation has timed out when connecting to OData by using SSIS in Project Online.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/26/2025
---

# The operation has timed out when connecting to OData by using SSIS in Project Online

## Symptoms

When you use Microsoft SQL Server Integration Services (SSIS) packages to download data from your Project Online OData feeds, you receive the following error message:  

> The operation has timed out.

## Status

We are currently investigating the issue.  

## Workaround

To work around this issue, edit the .NET Framework Machine.config files to increase the number of allowed connections to Microsoft SharePoint and Project Online on the server that your SSIS package is configured to run. To do this, follow these steps:

1. Edit the following files on the server that's running the SSIS package:

   %windir%\Microsoft.NET\Framework\\\<version>\config\machine.config

   %windir%\Microsoft.NET\Framework64\\\<version>\config\machine.config

   > [!NOTE]
   > For the \<version> folder placeholder, the correct value is typically the most recent version of the .NET Framework, such as 4.0.*xxxxx*. However, if you have configured your SSIS package to use a different .NET Framework version, update this value accordingly.

   :::image type="content" source="media/operation-times-out-if-connect-odata/edit-files.png" alt-text="Screenshot to edit the files on the server that's running the SSIS package.":::
2. Make a copy of both Machine.config files as a Backup.
3. Open each Machine.config file, and scroll all to way to the bottom of the file. At the very end of the file, add a space between the **</system.web>** and <**/configuration**> tags, and then paste the following snippet:

   ```xml
    <system.net>
    <connectionManagement>
    <add address = "https://contoso.sharepoint.com" maxconnection = "30" />
    </connectionManagement>
    </system.net>
    ```

   > [!NOTE]
   >
   > - You must replace the address with your SharePoint domain. For example, if your PWA site is `https://contoso.sharepoint.com/sites/pwa`, the address should be `https://contoso.sharepoint.com`.
   > - Consider increasing or decreasing the **maxconnection** value in this step, depending on how your SSIS package is configured. For example, if you have a larger number of feeds that you're pulling concurrently, you may need a larger number of connections. For only a few feeds, you can use a smaller value. For more information about the .NET Framework Connection Management setting, see [\<add> Element for connectionManagement (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/add-element-for-connectionmanagement-network-settings).
   > - After you're done adding the snippet, the edited file should resemble the following:
   >
   >     :::image type="content" source="media/operation-times-out-if-connect-odata/machine-config-file.png" alt-text="Screenshot shows an example of the edited file in Notepad." border="false":::

4. Save the changes, and then close the file.
5. Make sure that the edit is done on both Machine.config files that are listed in step 1.
6. To make sure that the setting takes effect, you can either stop and restart the application that the SSIS package runs under, such as SQLAgent, or restart the server.
