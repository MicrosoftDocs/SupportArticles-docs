---
title: Sign-in error when creating or joining a meeting
description: Provides a workaround for an issue in which users can't sign in to Skype for Business when they start the Skype for Business app, create a Skype meeting, or join a meeting.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: balram, jalalb
appliesto: 
  - Microsoft 365 (Enterprise, Business, Government, Education)
search.appverid: MET150
ms.date: 03/31/2022
---
# It might be your sign-in address or logon credentials error in Skype for Business

_Original KB number:_ &nbsp; 4486849

> [!NOTE]
> Skype for Business isn't included in Microsoft 365 Business but is included in Microsoft 365 Business Premium. However, the product IDs for Microsoft 365 Apps and Microsoft 365 Business Standard are the same. Therefore, Skype for Business is served as part of the Microsoft 365 Apps subscription. Therefore, if Microsoft 365 Apps is installed from a Microsoft 365 portal, Skype for Business is installed together with Microsoft 365 Apps.

## Symptoms

Users may experience the following symptoms.

### Symptom 1

When a user tries to sign in to the Skype for Business app, they receive the following error message:

> Can't sign in to Skype for Business. You didn't get signed in. It might be your sign-in address or logon credentials, so try those again. If that doesn't work, contact your support team.

### Symptom 2

Assume that Skype for Business is included or installed as part of Microsoft 365 Apps. When the user creates a new meeting, the **Skype Meeting** option is presented, but when the user selects this option, they receive an error message that prompts them to sign in to Skype for Business.

### Symptom 3

A user who has the Skype for Business client app installed on their computer is assigned a Microsoft 365 Business license only. When the user receives a Skype meeting request and tries to join the meeting, they are prompted to sign in, but sign in fails.

## Cause

This behavior is by design if Microsoft 365 Apps is installed from your Microsoft 365 portal.

## Workaround

To work around this issue, create a configuration.xml file that can be used by the Office Deployment Tool. To do this, go to [Office Customization Tool](https://config.office.com/).

For more information about configuration.xml files, see [Configuration options for the Office Deployment Tool](/deployoffice/office-deployment-tool-configuration-options).

For more information about product IDs, see [List of Product IDs which are supported by the Office Deployment Tool for Click-to-Run](/microsoft-365/troubleshoot/installation/product-ids-supported-office-deployment-click-to-run).

For example, here is content for a configuration.xml file that can be used:

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
