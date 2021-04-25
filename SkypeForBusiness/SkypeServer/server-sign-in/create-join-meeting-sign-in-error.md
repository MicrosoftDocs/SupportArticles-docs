---
title: Sign-in error when creating or joining a meeting
description: Provides a workaround for an issue in which users can't sign in to Skype for Business when they start the Skype for Business app, create a Skype meeting, or join a meeting.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: sharepoint-server-itpro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: balram, jalalb
appliesto:
- Microsoft 365 (Enterprise, Business, Government, Education)
search.appverid: MET150 
---
# It might be your sign-in address or logon credentials error in Skype for Business

_Original KB number:_ &nbsp; 4486849

> [!NOTE]
> Skype for Business isn't included in Office 365 Business but is included in Office 365 Business Premium. However, the product IDs for Office 365 Business and Office 365 Business Premium are the same. Therefore, Skype for Business is served as part of the Office 365 Business subscription. Therefore, if Office 365 Business is installed from an Office 365 portal, Skype for Business is installed together with Office 365 Business.

## Symptoms

Users may experience the following symptoms.

### Symptom 1

When a user tries to sign in to the Skype for Business app, they receive the following error message:

> Can't sign in to Skype for Business. You didn't get signed in. It might be your sign-in address or logon credentials, so try those again. If that doesn't work, contact your support team.

### Symptom 2

Assume that Skype for Business is included or installed as part of Office 365 Business. When the user creates a new meeting, the **Skype Meeting** option is presented, but when the user selects this option, they receive an error message that prompts them to sign in to Skype for Business.

### Symptom 3

A user who has the Skype for Business client app installed on their computer is assigned an Office 365 Business license only. When the user receives a Skype meeting request and tries to join the meeting, they are prompted to sign in, but sign in fails.

## Cause

This behavior is by design if Office 365 Business is installed from your Office 365 portal.

## Workaround

To work around this issue, create a configuration.xml file that can be used by the Office Deployment Tool. To do this, go to [Office Customization Tool](https://config.office.com/).

For more information about configuration.xml files, see [Configuration options for the Office Deployment Tool](/deployoffice/office-deployment-tool-configuration-options).

For more information about product IDs, see [List of Product IDs which are supported by the Office Deployment Tool for Click-to-Run](/office365/troubleshoot/installation/product-ids-supported-office-deployment-click-to-run).

For example, here is content for a configuration.xml file that can be used:

```xml
<Configuration>
  <Add OfficeClientEdition="64" Channel="Monthly" Version="-1" AllowCdnFallback="TRUE" ForceUpgrade="TRUE">
    <Product ID="O365BusinessRetail">
      <Language ID="MatchOS" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="OneNote" />
      <ExcludeApp ID="Lync" />
    </Product>
  </Add>
    <Updates Enabled="TRUE" />
</Configuration>
```
