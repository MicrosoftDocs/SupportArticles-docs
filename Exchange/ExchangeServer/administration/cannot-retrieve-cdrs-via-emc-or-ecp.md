---
title: Cannot retrieve CDRs via EMC or ECP
description: Works around an issue in which you cannot retrieve CDRs by using Exchange Server 2010 EMC or ECP. This issue occurs after you move an e-Discovery arbitration mailbox from Microsoft Exchange Server 2010 to Exchange Server 2013.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: tonysmit, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Cannot retrieve CDRs by using EMC or ECP in an Exchange Server 2010 and 2013 coexistence environment

_Original KB number:_ &nbsp; 2769371

## Symptoms

Assume that you move an e-Discovery arbitration mailbox from Exchange Server 2010 to Exchange Server 2013. In this situation, you cannot retrieve the.CDRs from EMC, EMS, or ECP in Exchange Server 2010.

## Workaround

To work around this issue, use the Exchange admin center (EAC) in Exchange Server 2013 to retrieve the CDRs.

1. Go to the following Microsoft website to open the EAC:  
   `https://<exchange2013cas>/ecp`

2. Sign in to the EAC by using the administrator account.
3. Select **Unified Messaging**, select **...**, and then select **Call statistics** or **User call logs**  to retrieve the CDRs (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-retrieve-cdrs-via-emc-or-ecp/options-to-retrieve-cdrs.png" alt-text="Screenshot of the options to retrieve CDRs":::
