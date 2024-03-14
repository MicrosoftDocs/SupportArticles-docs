---
title: Error when uploading Viva Connections desktop package
description: Provides troubleshooting steps to determine why the manifest file can't be read when uploading the Viva Connections desktop package to the Teams admin center.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
localization_priority: Normal
ms.custom: 
  - CI 159609
  - CSSTroubleshoot
ms.reviewer: bpeterse
ms.date: 02/11/2022
search.appverid: 
- MET150
---

# Error when uploading Viva Connections desktop package

Your organization has decided to use the custom line of business Viva Connections desktop app. After the Viva Connections desktop package is created as a .zip file, you try to upload the package to the Microsoft Teams admin. However, you receive one of the following error messages:

> We can't read the manifest file. Try again later.

Or

> We can't upload the app. Try again.

## Check the manifest file

To troubleshoot this issue, check the manifest file that's included in the .zip file. The information in the manifest must follow specific [schema requirements](/microsoftteams/platform/resources/schema/manifest-schema). These requirements include character limits on the information that you provide when you build the package. The PowerShell cmdlet that you use to build the package specifies these character limits, but for only some of the information.

Verify that the following character limits are met in the manifest file:

- Name of the app as it should appear in Teams: <=30 characters
- Short description of the app: <=80 characters
- Long description of the app: <=4000 characters
- Your organization's name: <=30 characters

Additionally, the package must follow these guidelines:

- All site URLs must start as "https://". For example:

  - `https://<contoso>.sharepoint.com` for the SharePoint home site
  - `https://<www.contoso.com>` for the organization's public website

- The files for the [app icons](/microsoftteams/platform/concepts/build-and-test/apps-package#app-icons) must be in .PNG format and meet these specific sizing requirements:

  - 192x192 pixels for the colored icon
  - 32x32 pixels for the outline (monochrome) icon

After you check the information in the manifest file for these character limits and conditions, and update the information as necessary to meet the requirements, try to upload the .zip file again.
