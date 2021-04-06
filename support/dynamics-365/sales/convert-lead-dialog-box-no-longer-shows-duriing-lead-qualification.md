---
title: Convert Lead no longer appears during lead qualification
description: The Convert Lead dialog box does not show during the lead qualification in Microsoft Dynamics CRM Online. This is by design.
ms.reviewer: debrau
ms.topic: article
ms.date: 
---
# The Convert Lead dialog box no longer appears during lead qualification in Microsoft Dynamics CRM Online

This article introduces a by design behavior that the **Convert Lead** dialog box no longer shows during lead qualification in Microsoft Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2808201

## Symptoms

After applying the latest Product Update related to the December 2012 Service Update for Microsoft Dynamics CRM Online, users may notice that the lead Qualify button no longer presents the **Convert Lead** dialog box. This dialog box traditionally allowed users to choose the associated sales records to create during qualify, including Contact, Account, and Opportunity.

## Cause

This functionality is considered by design.

## More information

The qualify button will automatically create the related Opportunity record based on the customer information entered into the Lead form. In addition, the associated Contact and Account records will also be automatically created based on the First Name, Last Name, and Company Name field data, respectively.

After the lead is qualified, the lead form will refresh to a read-only state, and the new opportunity record will not appear on the screen. In addition, duplicate Account or Contact records may be created based on the lead data. Microsoft is aware of both of these symptoms and will be addressing these issues in a future update.
