---
title: Can't save an SLA item due to the Nullable object must have a value error
description: Provides a resolution for the Nullable object must have a value error that occurs when you save an SLA item.
ms.reviewer: sdas
ms.author: ankugupta
ms.date: 08/09/2023
---
# Can't save an SLA item

This article provides a resolution for the "Nullable object must have a value" error message that occurs when you try to save a service-level agreement (SLA) item.

## Symptoms

When you try to save an SLA item that has the value of `msdyn_advancedpauseconfiguratio` set to **NULL**, the following error message occurs.

> Nullable object must have a value.

:::image type="content" source="media/sla-item-pause-configuration/nullable-object-must-have-a-value-error.png" alt-text="Screenshot that shows the error that occurs when you save an SLA item." border="false":::

## Cause

This issue occurs when the SLA items are created before the `msdyn_advancedpauseconfiguration` property is added. The SLA items that are created after that have a **False** default value and don't have this issue.

## Resolution

In the **Pause Configurations** section of an SLA item, set the toggle to **Yes** for **Override Criteria** to pause the SLA item, then set it back to **No**, and save the SLA item.

:::image type="content" source="media/sla-item-pause-configuration/sla-advance-pause-config.png" alt-text="Screenshot that shows how to enable or disable the advance pause configuration.":::

The **Pause Configurations** section doesn't appear when **Allow Pause and Resume** is set to **No**. In this scenario, take the following steps to set the value of the `msdyn_advancedpauseconfiguration` to **False**.

1. Open an SLA item record in an SLA.
2. Press <kbd>F12</kbd> to open the developer tools window.
3. Go to console.
4. Copy the script from the [Mitigation script](#mitigation-script) section of this article.
5. Make sure you pass the correct `slaId` at line 1.
6. Press <kbd>Enter</kbd>.
7. Wait for few seconds until the script execution succeeds.
8. Go back to Dynamics 365 Customer Service and refresh the page by using <kbd>Ctrl</kbd>+<kbd>F5</kbd>.
9. Edit the SLA item and save.
10. Repeat the same steps for all the SLAs.

## Mitigation script

```JavaScript
var slaId = "d68cec48-610a-eb11-a813-000d3abfb73c";
Xrm.WebApi.retrieveMultipleRecords("slaitem", "?$select=slaitemid,msdyn_advancedpauseconfiguration&$filter=_slaid_value eq " + slaId).then(
    function success(result) {
		// define the data to update a record
		var data =
		{
			"msdyn_advancedpauseconfiguration": false,
		}
        for (var i = 0; i < result.entities.length; i++) {

			if(result.entities[i].msdyn_advancedpauseconfiguration === null)
			{
				// update the record
				Xrm.WebApi.updateRecord("slaitem", result.entities[i].slaitemid, data).then(
					function success(result) {
						console.log("SLAItem updated");
					},
					function (error) {
						console.log(error.message);
					}
				);
			}
        }                    
    },
    function (error) {
        console.log(error.message);
    }
);
``````
