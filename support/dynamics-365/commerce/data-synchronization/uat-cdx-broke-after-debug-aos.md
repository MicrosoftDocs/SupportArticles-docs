---
title: Download sessions cannot be downloaded in UAT after debugging the environment. 
description: This articles instructions you how to correct an issue with download sessions not working after debugging in UAT performed. 
author: bstorie
ms.author: brstor
ms.topic: troubleshooting-problem-resolution 
ms.date: 07/18/2023 
---

# CDX Download jobs can't be downloaded in UAT/Sandbox
When a development machine is attached to a UAT/Standbox environment for debugging.  The Dev machine becomes part of the Batch group and it's picked up by the batch job creating CDX packages. 
The resulting download session package generation will succeed and a download session record created, however the file will be uploaded to the dev machine's Azure Storage account (usually locally emulated) instead of the Storage account of the sandbox environment.
That download session will fail to apply because the package cannot be downloaded from the UAT/Sandbox file storage and applied to channel database.

## Symptoms
The follow error messages might appear:

Failed to get download session url for channelId: [CSU] and download session id: [ID] 
Microsoft.DynamicsOnline.Infrastructure.Components.SharedServiceUnitStorage.SharedServiceUnitNotFoundException: Record for Id - [GUID]  not found.

### Resolution  
Remove the Dev machine from the Server Configuration Manager form and re-generate the download session.

1. Go to System Administration module > Setup > Server Configuration
2. Locate the Dev machine AOS record 
 >Note: The name of this will include the word dev
3. Select that record
4. Click Delete
5. Go to Retail and Commerce module > Inquiries and reports > Commerce Data Exchange > Download sessions
6. Select the download session that was failing
7. Click Rerun



##Reference
[Debug a copy of the production database](/dynamics365/fin-ops-core/dev-itpro/database/dbmovement-scenario-debugdiag)
