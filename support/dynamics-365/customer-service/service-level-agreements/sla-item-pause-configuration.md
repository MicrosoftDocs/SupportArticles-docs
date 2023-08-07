---
title: Unable to save an SLA Item due to the error 'Nullable object must have a value'
description: Provides a resolution for the issue where an SLA Item failed to save due to the error “Nullable object must have a value”.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 07/18/2023
---
# Unable to save an SLA Item

This article provides a resolution for the issue Resolves the issue that prevented an SLA Item from saving because of the error “Nullable object must have a value”.

## Symptoms

This issue is occurring for all the SLA Items which had the value of **msdyn_advancedpauseconfiguratio** set to NULL.
:::image type="content" source="media/sla-item-pause-configuration/sla-item-set-to-null.png" alt-text="Screenshot that shows an error while saving SLA Item." border="false":::

## Cause

This issue occurs when the SLA Items were created before the msdyn_advancedpauseconfiguration property was added. The SLA Items created after that have a default value of False and do not face this issue.

## Resolution

To solve this issue, take the following steps:

The Override Criteria toggle can be set to Yes, then back to No and saved.
:::image type="content" source="media/sla-item-pause-configuration/sla-advance-pause-config.png" alt-text="Screenshot that shows how to enable or disable advance pause configuration." border="false":::

In case the Pause Configurations sections is not visible due to *Allow Pause and Resume* set to No, follow the below steps to set the value to false.
1. Navigate to SLA
2. Open any SLA Item records
3. Open the Developer Tool (press F12)
4. Go to console
5. Copy the script from the file [Mitigation-Script.txt](/media/sla-item-pause-configuration/mitigation-script.txt)
6. Make sure we are passing correct SLAId at line 1
7. Press enter
8. Wait for few seconds till the script execution succeeds.
9. Go back to CRM and Refresh the page (Ctrl +F5)
10. Edit the SLA Item and Save.
11. Repeat the same for all SLA's.