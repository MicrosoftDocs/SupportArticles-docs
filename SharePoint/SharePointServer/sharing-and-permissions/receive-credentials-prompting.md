---
title: You're prompted for credentials when you open documents anonymously
description: When you open documents anonymously or by using Windows Installer (MSI) based version of Office applications, you're prompted for credentials.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# You're prompted for credentials when you open documents anonymously in SharePoint Server 2016

## Applies to:

- Microsoft SharePoint Server 2016
- Windows Installer (MSI) based version of Microsoft Office 2016 applications (does not apply to Microsoft 365 applications)
- Anonymous access that is enabled for the SharePoint site or library
- Accessing Office documents anonymously
- Accessing Office documents by using a different account than the one that you used to logged in to Windows

## Symptoms

When you open documents in SharePoint Server 2016 by using Windows Installer (MSI) based version of Office applications, you are prompted for credentials if the conditions in the "Applies to" section are met.

## Why this issue occurs

Office applications send an **Authorization: Bearer** header for compatibility with SharePoint Online and OneDrive for Business. SharePoint Server 2016 sends an HTTP 401 authentication prompt because of an issue in the way that SharePoint Server 2016 on-premises handles requests that have the **Authorization: Bearer** header, and also because of the absence of the **X-IDCRL_ACCEPTED: t** header.

## How to work around this issue

To work around this issue, disable OPTIONS requests for the affected web applications, and then use the URL Rewrite rules to effectively remove the **Authorization: Bearer** header from HEAD requests. Only supported URL Rewrite rules for SharePoint Server 2016 are used to remove a request header value. For more information, see [Supportability of rewrites and redirects in SharePoint 2016, 2013, 2010, and 2007](https://support.office.com/article/supportability-of-rewrites-and-redirects-in-sharepoint-2016-2013-2010-and-2007-a74a19f2-a59a-4b39-8be4-ce63e50139fa).

To implement this workaround, follow these steps.

### Step 1: Block OPTIONS requests for the web application through Web.config

To block OPTIONS requests, change the Web.config file for the web application as follows:

```xml
<system.webServer>
…
    <security>
      <requestFiltering allowDoubleEscaping="true">
            <verbs applyToWebDAV="false">
                       <remove verb="OPTIONS" />
               <add verb="OPTIONS" allowed="false" />
            </verbs>
```

> [!NOTE]
> OPTIONS requests are not blocked for Web Distributed Authoring and Versioning (WebDav) requests.

### Step 2: Download and install the IIS URL Rewrite extension

Download and install the [IIS URL Rewrite extension](https://www.iis.net/downloads/microsoft/url-rewrite) on the SharePoint Web Front End (WFE) servers.

### Step 3: Add the HTTP_Authorization server variable to IIS

1. Start **Internet Information Services (IIS) Manager**, select the SharePoint server in the left pane, and then select **URL Rewrite** in the center pane.
1. In the right pane, select **View Server Variables**.
1. To add a new server variable, select **Add**.
1. Type a server variable name,such as **HTTP_Authorization**, and then select **OK**.
1. In the right pane, select **Back to Rules**.
1. Verify that the **HTTP_Authorization** server variable is added in the ApplicationHost.config file, as follows:

   ```xml
   <system.webServer>
   ….
        <rewrite>
            <allowedServerVariables>
                <add name="HTTP_Authorization" />
            </allowedServerVariables>
        </rewrite>
   ```

### Step 4: Add a rule to stop processing URL rewrite rules for other request methods

You can add a rule to stop processing further URL rewrite rules if the request method is not HEAD (change only HEAD requests). To do this, follow these steps:

1. Select the web application, and then select **URL Rewrite**.
1. In the right pane, select **Add Rule(s)** to add a new rule.
1. Type a rule name, such as **Authrule-HEADonly**.
1. In the **Match URL** section, specify the following values:

   1. **Requested URL**: Matches the Pattern
   1. **Using**: Regular Expressions
   1. **Pattern**: ```^(?!.*\.aspx).*$```
   1. **Ignore case** option: selected

1. In the **Conditions section**, select **Add**, and then specify the following values:

   1. **Condition input**: {REQUEST_METHOD}
   1. **Check if input string**: Does Not Match the Pattern
   1. **Pattern**: HEAD
   1. **Ignore case** option: selected

1. Edit the **Action section** as follows:

   1. **Action type**: None
   1. **Stop processing of subsequent rules** option: selected
   1. In the right pane, select **Apply** -> **Back to Rules**.

> [!NOTE]
> Make sure that the rule is enabled. To do this, look for the **Disable Rule** option in the right pane. This option is displayed after you select the rule.

### Step 5: Add a URL Rewrite rule to remove the Authorization: Bearer header

To effectively remove the **Authorization: Bearer** header for requests, use a URL Rewrite rule, as follows:

1. Select the web application, and then select **URL Rewrite**.
1. In the right pane, select **Add Rule(s)** to add a new rule.
1. Type a rule name, such as **Authrule**.
1. In the **Match URL** section, specify the following values:

   1. **Requested URL**: Matches the Pattern
   1. **Using**: Regular Expressions
   1. **Pattern**: ```^(?!.*\.aspx).*$```
   1. **Ignore case** option: selected

1. In the **Server Variable** section, select **Add**, specify the following values and then select OK:

   1. Server variable name: **HTTP_Authorization**
   1. **Value**: None
   1. **Replace the existing value** option: selected

1. In the **Action** section, specify the following values

   1. **Action Type**: None
   1. **Stop processing of subsequent rules: selected**

1. In the right pane, select **Apply** -> **Back to Rules**.

> [!NOTE]
> Make sure that the rule is enabled. To do this, look for the **Disable Rule** option in the right pane. This option is displayed after you select the rule.

## Resolve this issue in the SharePoint Server 2016 farm

Repeat all the steps from the previous section on every SharePoint Web Front End (WFE) server in the farm to make sure that all servers are configured identically. If you have already used rewrite rules, the two rules from the previous section need to be set as the last two in the list because the HEAD rule will disable subsequent rules.

Because of limitations in the IIS URL Rewrite extension, the rules can't currently be combined in a way that lets them work correctly. This situation may change in a future revision of the extension, or an alternative configuration may be found in the future. For now, these methods are the best confirmed way to resolve this issue by using URL Rewrite.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
