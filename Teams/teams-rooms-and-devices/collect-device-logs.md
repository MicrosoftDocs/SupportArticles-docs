---
title: Collect Android Teams device logs
description: Describes how to use Teams admin center to collect Android device logs that run Teams.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Device Management (TAC)
  - CI 160238
  - CSSTroubleshoot
ms.reviewer: miaitelh, mattslomka
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 08/18/2026
---
# Collect Teams device logs

If you experience issues when you try to use Microsoft Teams devices, you'll have to collect diagnostic logs to troubleshoot the issues. There are multiple methods available to collect Teams device logs but the recommended option is to use the Pro Management Portal.

## Collect logs by using the Pro Management Portal

1. Log in to the [Teams Pro Management Portal](/microsoftteams/rooms/enrolling-mtrp-managed-service).
1. Select **Rooms** on the navigation menu in the left pane and then select the impacted device.
4. Select the **Actions** tab > **Log Collection**.
6. Select **Run**, and if applicable, select the logs that you want to collect.
8. After a few minutes, open the **Activity** tab.
9. Under **Room logs**, view the most recent log collection and select the Download icon.

The device logs will be downloaded to your computer, and you can open them or share them with a Microsoft Support professional for further assistance.

## Collect Teams Rooms on Windows logs locally

You can use Teams PowerShell to collect logs locally by using the log collection script that ships with the Microsoft Teams Rooms app.

In [Admin mode](/microsoftteams/rooms/rooms-operations#switching-to-admin-mode), start an elevated command prompt, and run the following command:

```PowerShell
powershell -ExecutionPolicy unrestricted c:\rigel\x64\scripts\provisioning\ScriptLaunch.ps1 CollectSrsV2Logs.ps1
```

The logs are output into a .zip file that's stored in the C:\rigel folder.

## Collect Teams Rooms on Android logs locally

Use the Original Equipment Manufacturer (OEM) tooling or web management portal to collect logs locally.
