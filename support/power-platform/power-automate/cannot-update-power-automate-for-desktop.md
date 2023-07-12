---
title: Cannot update Power Automate for desktop
description: Provides a resolution to the issue where Power Automate for desktop cannot be updated.
ms.reviewer: pefelesk
ms.date: 7/7/2023
ms.subservice: power-automate-desktop-flows
---
# Can't update Power Automate for desktop

This article provides a resolution to the issue where Power Automate for desktop cannot be updated.

_Applies to:_ &nbsp; Power Automate

## Symptoms

When trying to open Power Automate for desktop for the first time, the following message is displayed:

:::image type="content" source="media/cannot-update-power-automate-for-desktop/Power-Automate-needs-an-update.png" alt-text="Power Automate needs an update.":::

## Verifying issue

1. Make sure that you have an active internet connection. 
2. Go to Windows Services and make sure that the "Windows Update" service **is not** running. 

## Cause

This issue could occur because the "Windows Update" service is not running/is disabled.  

## Resolution 

Follow one of the options below: 
### Option 1 
1. Go to Windows Services and enable the Windows Update service. 
2. Launch Power Automate 
### Option 2 
1. Open the Windows Settings 
2. Go to Troubleshoot > Other troubleshooters 
3. Run the Windows Update troubleshooter and wait for it to complete 
4. Launch Power Automate 
### Option 3 
1. Uninstall Power Automate 
2. Open the Microsoft Store and install Power Automate 
