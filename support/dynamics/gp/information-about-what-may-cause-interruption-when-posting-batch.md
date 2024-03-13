---
title: What may cause interruption when posting a batch
description: Discusses suggestions that can help you determine the cause of frequent posting interruptions in Microsoft Dynamics GP.
ms.reviewer: 
ms.date: 03/13/2024
---
# Information about what may cause an interruption when you post a batch in Microsoft Dynamics GP

This article discusses what may cause an interruption when you post a transaction or a batch in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 859917

Posting interruptions may occur periodically. If posting interruptions frequently occur, examine Microsoft Dynamics GP to determine the potential causes. The following troubleshooting suggestions can help you determine what may cause frequent posting interruptions.

- If the interruption occurs on a specific client computer every time, the client computer may have damaged code. If you have a client computer that does not experience posting interruptions, copy the code from the working client computer to the nonworking client computer. You may also reinstall Microsoft Dynamics GP on the nonworking client computer.
- Post a batch from the server. If you can post from the server, the problem may be in the network. Posting from the server may be more effective.
- If the interruption occurs for a specific user, the User ID may be damaged. Create a new User ID for the user.
- Verify that the check links process is run periodically in Microsoft Dynamics GP.
- When the posting interruption occurs, determine whether there is a common vendor, customer, item, or employee included in the batches. If there is a common vendor, customer, item, or employee in the batches, determine whether there is damage to the common vendor, customer, item, or employee.
- If the client computers experience power fluctuations or surges, you may experience posting interruptions.
- Corrupt Reports/Forms dictionaries. This may happen especially if you recently upgraded or updated to a new service pack. To verify the path for the forms and reports dictionaries, select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **System** and select **Edit Launch File**. Under the product name, select Microsoft Dynamics GP and then the location of the dictionaries will populate at the bottom of the window. See [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-reports-dic-file-in-microsoft-dynamics-gp-8a85339e-92ed-03ed-5ca8-f538a5c502a7) for steps on how to recreate the Reports.dic and [How to re-create the Forms.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-forms-dic-file-in-microsoft-dynamics-gp-4cbd73e5-20c9-0baf-af55-3ea467eb1d0c) for steps on how to recreate the Forms.dic file.
