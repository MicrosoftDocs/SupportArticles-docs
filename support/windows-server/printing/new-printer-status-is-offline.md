---
title: The new printer status is Offline
description: Provides a solution to an issue where the new printer status is Offline after you delete a print queue and then restart a Windows-based computer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, AndrewYa
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# The new printer status is Offline after you delete a print queue and then restart a Windows-based computer

This article provides a solution to an issue where the new printer status is Offline after you delete a print queue and then restart a Windows-based computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2027593

## Symptoms

Consider the following scenario:

- You delete a print queue while it is in an Offline status.
- You add a new print queue that has the same name as the old print queue.
- You restart the computer.

In this scenario, the status of the new print queue is displayed as **Offline**.

## Cause

This problem occurs if the computer has the following registry value configured when you set the printer to the **Offline** status:

Key: `HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Print\Printers\<print queue name>`
Value: PrinterOnLine  
Data: 0

However, this value isn't deleted by the Localspl.dll file when the print queue is deleted. So when you add a print queue that has the same name as the old print queue, the new printer queue inherits the **Offline** status of the deleted print queue.

## Resolution

To resolve this issue, right-click the new print queue in the Printers and Faxes tool, and then clear the **Use Printer Offline** setting. This resets the registry key to the correct value. Instead, you can delete the registry key that is mentioned in the [Cause](#cause) section after you delete a print queue but before you add a new print queue of the same name.

### Did this fix the problem

- Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, leave a comment by sending us an [email](mailto:fixit4me@microsoft.com?subject=kb) message.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
