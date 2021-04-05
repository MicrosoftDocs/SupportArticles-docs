---
title: Automatic Record Creation Rules fail
description: Automatic Record Creation Rules fail when the sender of the email is a Contact and a User in Microsoft Dynamics CRM. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Automatic Record Creation Rules fail when the sender of the email is a Contact and a User in Microsoft Dynamics CRM

This article provides a resolution for the **You should specify a parent Contact or Account** error that occurs when Automatic Record Creation Rules fail.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3094208

## Symptoms

Automatic Record Creation Rules fail when the sender of the email is a Contact and a User in Microsoft Dynamics CRM. When you open the Rule Item System Job, you will see if fails with the following error:

> You should specify a parent Contact or Account.

## Cause

This is a known issue and is scheduled to be fixed in a September Microsoft Dynamics CRM Online update.

## Resolution

Once this fix has been applied to the Microsoft Dynamics CRM Online organization, it will be required to disable the Automatic Record Creation Rule, delete the Case Creation Step in the Rule Item, and recreate the Case Creation Step. This must be done, as the fix includes new Dynamic Value slugs to be created in the out-of-box Customer and Contact fields. To do this:

1. Go to **Settings** > **Service Management** > **Automatic Record Creation and Update Rules**.
2. Select the check mark next to the Rule and select **Deactivate**.
3. Then, open the Automatic Record Creation Rule.
4. Select to open the specified Rule Item.
5. Under **Actions**, select the **Create Case** step and select **Delete this Step**. Save the form.
6. Re-add the action to Create Case.
7. Select **Set Properties** and re-add any custom mappings. The out-of-box Customer and Contact fields will automatically populate to {null(Channel Properties)}. This value must remain, in order for the Email resolution to correctly correlate to the Contact or Account. If this value is changed, it cannot be reset manually and the Create Case step must be deleted and recreated again.
8. Save the form,
9. Re-enable the Automatic Record Creation Rule.

## More information

The current design of Automatic Record Creation Rules will not resolve the sender of an Email if it only exists as a User in Microsoft Dynamics CRM. It must also exist as a Contact or Account and can be created as a Contact automatically when received. To automatically create the sender of the Email as a Contact, select the Create records for email from unknown senders  checkbox in the Automatic Record Creation Rule. If this box is unmarked, the email address will be unresolved and the rule will not be triggered.
