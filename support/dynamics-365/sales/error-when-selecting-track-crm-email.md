---
title: Error when selecting Track in CRM on email
description: Provides a solution to an error that occurs when you select Track in CRM on an email from a sender that doesn't exist in CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# You do not have permission to access these records error when you select Track in CRM on an email from a sender that does not exist in CRM

This article provides a solution to an error that occurs when you select **Track** in CRM on an email from a sender that doesn't exist in CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3140762

## Symptoms

When you select **Track** in CRM within Microsoft Dynamics CRM for Outlook and the email is from a sender that doesn't exist as a record in CRM, the following error occurs:

> "You do not have permission to access these records. Contact your Microsoft Dynamics CRM administrator.Item Name = \<subject of email>"

## Cause

Your user record in Microsoft Dynamics CRM is missing read access for the Queue entity. Microsoft is aware of this issue and is investigating for a potential fix. In the meantime, you can use the workaround provided in the Resolution section.

## Resolution

Sign into Microsoft Dynamics CRM as a user with the System Administrator role. Locate the security role assigned to the user. On the **Core Records** tab of the security role, grant Read access for the Queue entity.

## More information

If you capture [How to enable tracing for the Microsoft Dynamics CRM for Outlook client](https://support.microsoft.com/help/2862031), the following information is logged:

> Principal user (Id={GUID}, type=8) is missing prvReadQueue privilege (Id=b140e729-dfeb-4ba1-a33f-39ff830bac90)
