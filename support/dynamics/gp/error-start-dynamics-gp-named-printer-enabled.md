---
title: Fail to start Microsoft Dynamics GP on a computer on which named printers are enabled 
description: Describes a problem in which Microsoft Dynamics GP exits unexpectedly while you are trying to start it. This problem occurs when named printers are enabled. Describes how to resolve the problem.
ms.topic: troubleshooting
ms.reviewer: theley, kyouells
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error when you try to start Microsoft Dynamics GP on a computer on which named printers are enabled: Application must close

This article provides a solution to an issue where you fail to start Microsoft Dynamics GP on a computer on which named printers are enabled.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 909739

## Symptoms

When you try to start Microsoft Dynamics GP, you may experience the following problem. When you click **OK** in the **Company Login** dialog box, Microsoft Dynamics GP exits unexpectedly without an error message. Or, Microsoft Dynamics GP exits unexpectedly, and you receive the following error message instead:

> Application must close.

## Cause

This problem occurs if the following conditions are true:

- Named printers are enabled on the computer on which you are trying to start Microsoft Dynamics GP.
- One of the following conditions is true:
  - The default printer for the System task series no longer exists. Or, the default printer for the Company task series no longer exists.
  - The printer drivers have been changed for the default printer for the System task series or for the default for the Company task series. Or, the printer drivers are not valid. When you start Microsoft Dynamics GP, the default printer for Microsoft Dynamics GP is changed to the default printer for the System task series in the Named Printers Options window.

## Resolution

To resolve this problem, temporarily disable named printers on the computer so that the default printer for Microsoft Dynamics GP is not changed when you start the program. Next, start Microsoft Dynamics GP, and then set up named printers correctly. After you do this, enable named printers. To do this, follow these steps:

1. Double-click the Dex.ini file.
2. In the file, locate the following line:  
    **ST_SetDefault=TRUE**

3. Change the value of the **ST_SetDefault** parameter to **FALSE**.
4. Save the changes, and then close the file.
5. Start Microsoft Dynamics GP.
6. On the **Tools** menu, click **Setup**, click **System**, and then click **Named Printers**.
7. Change the settings for the default printer for the System task series so that you specify a printer that exists.
8. Change the settings for the default printer for the Company task series so that you specify a printer that exists.

    > [!NOTE]
    > This step is optional. You only have to do this if a default printer for the Company task series is already set up.

9. Exit Microsoft Dynamics GP.
10. Double-click the Dex.ini file.
11. Change the value of the **ST_SetDefault** parameter to **TRUE**.

> [!NOTE]
> You can temporarily disable named printers by putting a semicolon in front of the **ST_MachineID=** setting in the Dex.ini file instead of setting the **ST_MachineID=** setting to **FALSE**.
