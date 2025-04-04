---
title: Missing form context for internal handlers on customized bookable resource forms
description: Address issues with customized forms based on the default bookable resource form for Dynamics 365 Field Service.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 03/31/2025
ms.custom: sap:Schedule Board
---
# Missing form context for internal handlers on customized bookable resource forms

This article helps resolve issues caused by missing form context for internal handlers on the bookable resource form in Microsoft Dynamics 365 Field Service.

## Symptoms

When you select a user from the field on the form while [creating a bookable resource](/dynamics365/field-service/set-up-bookable-resources) in Dynamics 365 Field Service, you might receive the following error message:

> Cannot read properties of undefined (reading 'getFormContext')

## Cause

The issue occurs because the system uses a customized form based on an outdated version of the bookable resource form. A change in the internal handlers for `onchange` events now requires the execution context to be passed in from the form.

## Resolution

Use one of the listed resolutions to ensure that the execution context is passed as the first parameter.

> [!IMPORTANT]
> The following resolutions assume that the script error references the `Mscrm.userid_onchange` function. If the error refers to other fields or functions, such as `Mscrm.accountid_onchange` or `Mscrm.contactid_onchange`, adapt the steps accordingly.

### Resolution 1: Update the form in Power Apps

1. Sign in to Power Apps and open the solution that contains the form.

1. Select the **User** field and go to the event settings.

1. Look for the `Mscrm.userid_onchange` event handler.

   If the handler doesn't exist:

   1. Add a new event of type **On Change**
   1. Select the **Scheduling/BookableResource/BookableResource_main_system_library.js** library.
   1. Enter _Mscrm.userid_onchange_ in the **Function** field.
   1. Ensure the **Enabled** and **Pass execution context as first parameter** checkboxes are selected.

   If the handler exists:

   1. Edit the handler and ensure the **Pass execution context as first parameter** checkbox is selected.

1. Save and publish the updated form.

### Resolution 2: Validate the customizations.xml file

1. Open the **customizations.xml** file from the solution associated with the customized form that shows the error in an editor.

1. In the `Handler` element of the `Mscrm.userid_onchange` function, ensure the `passExecutionContext` attribute is set to **true**.

1. Republish the solution.

### Resolution 3: Run a script in the browser console

To ensure this script has the permission to find and update the required information, you need to run it in a browser tab that has an active session with your enviornment. Additionally, your user account needs the permisssions to update the XML of the customized bookable resource form.

1. Open the environment in your browser. The following instructions use Microsoft Edge as an example.

1. Open **DevTools** by pressing F12 or navigating to ellipsis (&hellip;) > **More tools** > **Developer tools**

1. Select the **Console** tab in the DevTools and select **Clear Console**.

1. Copy and paste the following JavaScript code into the console.

1. Update the `ORG` constant in the script with your environment URL, for example, `contoso.crm.dynamics.com`.

1. Run the script and review the output to confirm the updates.

```JavaScript
const ORG = "<YOUR-ENVIRONMENT-URL>"; // for example "contoso.crm.dynamics.com"

async function fixBookableResourceForms() {

    console.log("Starting Bookable Resource Form fetch process...");

    let publishXML = false;

    try {

        const response = await fetch(`https://${ORG}/api/data/v9.2/systemforms?$filter=objecttypecode eq 'bookableresource'`);

        if (!response.ok) {

            throw new Error(`Error fetching resources: ${response.statusText}`);

        }

        const data = await response.json();

        const forms = data.value;

        if(forms.length !== 0) {

            for (const form of forms) {

                console.log(`  Checking form ${form.name} (${form.formid})...`);

                const formXML = form.formxml;

                const parser = new DOMParser();

                const xmlDoc = parser.parseFromString(formXML, "text/xml");

                const handlers = xmlDoc.getElementsByTagName("Handler");

                const userIdHandlers = []

                for (let i = 0; i < handlers.length; i++) {

                    const handler = handlers[i];

                    if (

                        handler.getAttribute("functionName") === "Mscrm.userid_onchange" &&

                        handler.getAttribute("libraryName") === "Scheduling/BookableResource/BookableResource_main_system_library.js"

                    ) {

                        userIdHandlers.push(handler);

                    }

                }

                if (userIdHandlers.length > 1) {

                    console.warn(`Form ${form.name} (${form.formid}) has more than 1 Mscrm.userid_onchange event handlers (has ${userIdHandlers.length}).`);

                }

                else if (userIdHandlers.length === 0) {

                    console.warn(`Form ${form.name} (${form.formid}) has 0 Mscrm.userid_onchange event handlers.`);

                    continue;

                }

                await Promise.all(userIdHandlers.map(async handler => {

                    if (

                        handler.getAttribute("functionName") === "Mscrm.userid_onchange" &&

                        handler.getAttribute("libraryName") === "Scheduling/BookableResource/BookableResource_main_system_library.js" &&

                        handler.getAttribute("passExecutionContext") === "true"

                    ) {

                        console.log(`    Form ${form.name} (${form.formid}) has the correct Mscrm.userid_onchange event handler.`);

                    }

                    else if (

                        handler.getAttribute("functionName") === "Mscrm.userid_onchange" &&

                        handler.getAttribute("libraryName") === "Scheduling/BookableResource/BookableResource_main_system_library.js" &&

                        (handler.getAttribute("passExecutionContext") === "false" || handler.getAttribute("passExecutionContext") === null)

                    ) {

                        console.log(`    Form ${form.name} (${form.formid}) has the Mscrm.userid_onchange event handler but the passExecutionContext attribute is not set to true. Setting it to true...`);

                        handler.setAttribute("passExecutionContext", "true");

                        const serializer = new XMLSerializer();

                        const updatedXml = serializer.serializeToString(xmlDoc);

                        await updateBookableResourceForms(form, updatedXml);

                        publishXML = true;

                    }

                    return Promise.resolve();

                }));

            }

        } else {

            console.log("No Bookable Resource forms found. Nothing was done");

        }

    } catch (error) {

        console.error(error.message);

    }

    if(publishXML) {

        console.log("Publishing changes...");

        await publishChanges();

        publishXML = false;

    }

    console.log("Finished");

}

async function updateBookableResourceForms(form, formxml) {

    console.log(`    Updating Bookable Resource Form ${form.name} (${form.formid}) ...`);

    try {

        const reqBody = JSON.stringify({formxml: formxml});

        const updateResponse = await fetch(`https://${ORG}/api/data/v9.2/systemforms(${form.formid})`, {

            method: 'PATCH',

            headers: {

                'Content-Type': 'application/json'

            },

            body: reqBody

        });

        if (!updateResponse.ok) {

            throw new Error(`Error updating form ${formid}: ${updateResponse.statusText}`);

        }

        console.log(`      Form ${form.name} (${form.formid}) updated successfully.`);

    } catch (error) {

        console.error(error.message);

    }

    console.log(`    Done updating Bookable Resource Form ${form.name} (${form.formid}).`);

}

async function publishChanges() {

    console.log("  Starting publish XML process...");

    const publishResponse = await fetch(`https://${ORG}/api/data/v9.2/PublishXml`, {

        method: 'POST',

        headers: {

            'Content-Type': 'application/json'

        },

        body: '{"ParameterXml": "<importexportxml><entities><entity>bookableresource</entity></entities></importexportxml>"}'

    });

    if (!publishResponse.ok) {

        throw new Error(`Error publishing XML: ${publishResponse.statusText}`);

    }

    console.log("  Done publish XML process.");

}

// Call the function

fixBookableResourceForms()
```
