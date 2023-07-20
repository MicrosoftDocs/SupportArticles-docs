---
title: Download sessions can't be downloaded in UAT after debugging
description: Provides a resolution for an issue where you can't download sessions in a sandbox user acceptance testing (UAT) environment after debugging. 
author: bstorie
ms.author: brstor
ms.date: 07/20/2023 
---
#  Commerce Data Exchange (CDX) download jobs can't be downloaded in a sandbox UAT environment

## Symptoms

When a DevTest machine is attached to a sandbox user acceptance testing (UAT) environment for debugging, the DevTest machine becomes part of the batch group, and it's picked up by the batch job to create Commerce Data Exchange (CDX) packages.

The resulting download session package generation succeeds, and a download session record is created. However, the package is uploaded to the DevTest machine's Azure storage account (usually locally emulated) instead of the storage account of the sandbox UAT environment. Additionally, you receive the following error messages:  

> Failed to get download session url for channelId: [CSU] and download session id: [ID]

> Microsoft.DynamicsOnline.Infrastructure.Components.SharedServiceUnitStorage.SharedServiceUnitNotFoundException: Record for Id - [GUID]  not found.

The download session fails to apply because the package can't be downloaded from the sandbox UAT environment's file storage, nor can it be applied to a channel database.

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
