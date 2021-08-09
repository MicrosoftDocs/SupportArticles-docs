---
title: You do not see the Get CRM for Outlook button
description: This article provides three resolutions for the problem that occurs when the Get CRM for Outlook button is missing.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# After uninstalling the Dynamics CRM Client for Outlook, you do not see the Get CRM for Outlook Button

This article helps you resolve the problem that occurs when the Get CRM for Outlook button is missing.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2500508

## Symptoms

After you uninstalled the Microsoft Dynamics CRM Client for Microsoft Office Outlook, you do not see the Get CRM for Outlook  button in Internet Explorer when you connect to Dynamics CRM server.

## Cause

If Internet Explorer was open during the uninstall of the Dynamics CRM Client for Outlook, it cannot reflect the registry key change caused by the uninstall process.

## Resolution

- Resolution 1:

  Close all the Internet Explorer processes, and launch the Dynamics CRM web page to see if the button is available.

- Resolution 2:

  Clear your Internet Explorer temporary files and launch the Dynamics CRM web page to see if the button is available.

- Resolution 3:

  Reboot the computer and launch the Dynamics CRM web page to see if the button is available.
