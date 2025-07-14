---
title: We couldn't find the file you wanted
description: This article describes SharePoint 2016 Microsoft Excel Online Web Part error. We couldn't find the file you wanted, and provides a solution.
author: helenclu
ms.author: luche
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: randring
ms.custom: 
  - sap:User experience\Webpart infrastructure
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# SharePoint 2016 Microsoft Excel Online Web Part error "We couldn't find the file you wanted"

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

## Scenario

You are trying to render Excel workbooks in the Microsoft Excel Online web part in SharePoint 2016 and are encountering the following error inside the web part when it attempts to load: "We couldn't find the file you wanted".

:::image type="content" source="media/excel-web-access-web-part-error/error.png" alt-text="Screenshot of the SharePoint 2016 Excel Online Web Part error message." border="false":::

You will notice that workbooks are rendering in the browser (view, edit, and preview) are all working fine assuming that there are no other issues.

The Unified Logging Service (ULS) logging won't have anything helpful, but you may see errors that resemble the following while SharePoint is trying to engage the workbook:

:::image type="content" source="media/excel-web-access-web-part-error/uls.png" alt-text="Screenshot of the ULS log says Failed to get WOPI target." border="false":::

Office Online Server Unified Logging Service (ULS) will have no messages related to this issue, because the request doesn't even make it to the server.

## Cause

The cause of this specific issue may be due to missing or custom bindings for Office Online Server. Specifically, could be missing the "syndicate" binding. This binding is specific to all Excel extensions and enables them to be rendered in web parts. In a stock binding scenario, you would see this when you run the Get-SPWOPIBinding cmdlet:

> [!NOTE]
> Your "WopiZone" and "ServerName" may differ.

```adoc
Application : Excel
Extension : ODS
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : internal-https

Application : Excel
Extension : XLSB
ProgId 
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : internal-https

Application : Excel
Extension : XLSM
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : internal-https

Application : Excel
Extension : XLSX
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : internal-https

Application : Excel
Extension : ODS
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : external-https

Application : Excel
Extension : XLSB
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : external-https

Application : Excel
Extension : XLSM
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : external-https

Application : Excel
Extension : XLSX
ProgId :
Action : syndicate
IsDefaultAction : False
ServerName : <SERVERNAME>
WopiZone : external-https
```

## Solution

If you find the "Syndicate" binding is missing, add the "syndicate" action to your WOPI bindings by running the following cmdlet from one of your SharePoint servers as a farm admin in an administrator enabled SharePoint PowerShell console:

```powershell
new-spwopibinding -server oos2016ocsi -action syndicate
```

> [!NOTE]
> This issue only affects the products that are mentioned earlier and may or may not be the only way to experience this specific error. At the time of this writing, we have only seen this happen in this specific scenario.
