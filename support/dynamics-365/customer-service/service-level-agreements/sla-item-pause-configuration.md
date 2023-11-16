---
title: Can't save an SLA item due to Nullable object must have a value error in Dynamics 365 Customer Service
description: Provides a resolution for the Nullable object must have a value error that occurs when you save an SLA item in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: ankugupta
ms.date: 08/18/2023
---
# "Nullable object must have a value" error occurs when saving an SLA item

This article provides a resolution for the "Nullable object must have a value" error message that occurs when you try to save a service-level agreement (SLA) item.

## Symptoms

When you try to save an SLA item that has the value of `msdyn_advancedpauseconfiguration` set to **NULL**, the following error message occurs:

> Nullable object must have a value.

## Cause

This issue occurs when the SLA item is created before the `msdyn_advancedpauseconfiguration` property is added. SLA items created after the property is added have a default value of **False**, and don't have this issue.

## Resolution

In the **Pause Configurations** section of an SLA item, set the **Override Criteria**  toggle to **Yes** to pause the SLA item, then set it back to **No**, and save the SLA item.

:::image type="content" source="media/sla-item-pause-configuration/sla-advance-pause-config.png" alt-text="Screenshot that shows how to enable or disable the advance pause configuration.":::

The **Pause Configurations** section doesn't appear when **Allow Pause and Resume** is set to **No**. In this scenario, follow these steps to set the value of `msdyn_advancedpauseconfiguration` to **False**.

1. Open an SLA item record in an SLA.
2. Press <kbd>F12</kbd> to open the developer tools window.
3. Go to **Console**.
4. Copy the script from the [Mitigation script](#mitigation-script) section in this article.
5. Make sure you pass the correct `slaId` in the first line.
6. Press <kbd>Enter</kbd>.
7. Wait a few seconds until the script execution succeeds.
8. Go back to Dynamics 365 Customer Service, and then select <kbd>Ctrl</kbd>+<kbd>F5</kbd> to refresh the page.
9. Edit and save the SLA item.
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
```
