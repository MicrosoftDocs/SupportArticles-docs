---
title: CDX Download jobs failing due to data package not found in UAT/Sandbox
description: Provides a resolution for an issue where you can't download sessions in a sandbox user acceptance testing (UAT) environment after debugging. 
author: bstorie
ms.author: brstor
ms.date: 05/22/2025
ms.custom: sap:Data synchronization\Issues with download sessions in CSU
---
#  Commerce Data Exchange (CDX) download jobs can't be downloaded in a sandbox UAT environment

## Symptoms

When a DevTest machine is attached to a sandbox user acceptance testing (UAT) environment for debugging, the DevTest machine becomes part of the batch group, and it's picked up by the batch job to create [Commerce Data Exchange (CDX)](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx) packages.

The resulting download session package generation succeeds, and a download session record is created. However, the package is uploaded to the DevTest machine's Azure storage account (usually locally emulated) instead of the storage account of the sandbox UAT environment. The download session will then fail to download and apply to the channel database. The system will show the following error messages:  

> Failed to get download session url for channelId: [CSU] and download session id: [ID]

> Data package not found. Run again to create a new file. In Sandbox environments, in the Server configuration form, remove all developer environments from the batch listings.


## Resolution

To solve this issue, remove the DevTest machine from the **Server Configuration Manager** form and rerun the download session.

1. Go to the **System Administration** module > **Setup** > **Server Configuration**.
2. Locate the Application Object Server (AOS) record of the DevTest machine.

   > [!NOTE]
   > The name of the record includes the word "dev."

3. Select **Delete** to remove the AOS record.
4. Go to the **Retail and Commerce** module > **Inquiries and reports** > **Commerce Data Exchange** > **Download sessions**.
5. Select the failed session.
6. Select **Rerun**.

## More information

For more information, see [Debug a copy of the production database](/dynamics365/fin-ops-core/dev-itpro/database/dbmovement-scenario-debugdiag).
