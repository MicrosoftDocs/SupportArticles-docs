---
title: SharePoint on Windows Server 2019 search errors
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Server
  - Windows Server 2019
ms.custom: 
  - sap:Search\Performance (such as crawl, query, indexing , and content processing)
  - CI 125656
  - CSSTroubleshoot
ms.reviewer: cesart
description: Resolves an issue where Windows Server 2019 on SharePoint throws search errors.
---

# SharePoint search errors on Windows Server 2019

## Symptoms

When running SharePoint on Windows Server 2019 you see errors when searching, which include a Correlation ID.

:::image type="content" source="media/search-errors-windows-server-2019/search-errors-windows-server-2019-1.png" alt-text="Screenshot of the SharePoint search error with Correlation ID.":::

## Cause

A non-SharePoint pre-defined rule called "Windows Communication Foundation Net.TCP Listener Adapter (TCP-In)" is intended to allow port 808. However, in Windows Server 2019, it is tied to the following file:

```
"%systemroot%\Microsoft.NET\Framework64\v3.0\Windows Communication Foundation\SMSvcHost.exe"
```

In previous versions of Windows Server, this rule did not specify a program location. 

The task manager shows that the version SharePoint uses is located here:

```
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\SMSvcHost.exe
```

The rule will not run since the program locations do not match, causing SharePoint to throw errors.

## Workaround

To work around this problem, create a rule that allows port 808 for any application under Inbound rules by using the following steps:

1. In the Windows Server **Start** menu, type **Windows Firewall**. (Or open  **Control Panel** > **System and Security** > **Windows Firewall**.) 
1. Select **Advanced Settings** in the left-hand pane, and then **Inbound Rules**. 
1. In the **Actions** pane on the right, select **New Rule**.
1. In the New Rule wizard, select **Port** and then select **Next**.
1. Select the **TCP** check box, select the **Specific local ports** check box, enter **808**, and then select **Next**.
1. Select **Allow the connection** and then select **Next**.
1. Select which profiles to apply the rule to. (The default is to have all three selected.)
1. Enter a rule name and select **Finish**. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
