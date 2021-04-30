---
title: Errors when trying to manage dial plans
description: Describes errors that occur if you try to manage dial plans with an unlicensed account. 
ms.date: 4/30/2021
author: meerak
ms.author: v-matham
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 148559
- CSSTroubleshoot 
ms.reviewer: teams_triage
---

# Errors when trying to manage dial plans 

## Symptoms

When you try to access a dial plan in the Microsoft Teams admin center, you see the following error:

> We can’t get the effective dial plan so the dial plan can’t be tested.

:::image type="content" source="./media/errors-managing-dial-plans/cant-get-dial-plan.png" alt-text="Test dial plan window shows error":::

When you try to test a dial plan, you see the following error:

> Something went wrong while testing this phone number. If you continue to have problems, contact Microsoft customer support. 

:::image type="content" source="./media/errors-managing-dial-plans/something-went-wrong.png" alt-text="Test number window shows error":::

If you try to use Teams PowerShell to see the details of a dial plan by running the [Get-CsEffectiveTenantDialPlan cmdlet](/powershell/module/skype/get-cseffectivetenantdialplan), you get the following error:

Management object not found for identity <UPN> 

:::image type="content" source="./media/errors-managing-dial-plans/management-object.png" alt-text="Teams PowerShell shows error":::
  
## Cause

The above actions trigger a query to look up the value of the EffectiveTenantDialPlanName property, which is used to populate the information in the dial plan. If you’re an administrator without a product license, this query can’t run. The value is not returned and the errors occur.

## Resolution

Your administrator account must be [assigned a Teams license](microsoft-365/admin/manage/assign-licenses-to-users) if you need to [manage dial plans](/microsoftteams/create-and-manage-dial-plans).