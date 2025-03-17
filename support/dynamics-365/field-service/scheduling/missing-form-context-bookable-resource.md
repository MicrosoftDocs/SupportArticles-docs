---
title: Missing form context for internal handlers on customized bookable resource forms
description: Address issues with customized forms based on the default bookable resource form for Dynamics 365 Field Service.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 03/13/2025
ms.custom: sap:Schedule Board
---

# Missing form context for internal handlers on customized bookable resource forms

This article helps resolve issues caused by missing form context for internal handlers on the bookable resource form in Microsoft Dynamics 365 Field Service.

## Symptoms

When opening the form to create a bookable resource, the error message **Cannot read properties of undefined (reading 'getFormContext')** appears when selecting a user from the field.

## Cause

The system uses a customized form that is based on an old version of the bookable resource form. There was a change in the internal handlers for *onchange* events. They require the execution  context to be passed in from the form.

## Resolution

You can address such isuses through Power Apps, by editing the form definitions of the customized forms in the corresponding customizations.xml file, or by running a script in the browser console to update the onchange event. The following resolutions assume that the script error references the function Mscrm.userid_onchange. If the error shows on other fields and references other functions, adapt the resolution steps to these fuctions.

### Update the form in Power Apps

1. Sign in to Power Apps and open the solution that contains the form.

1. Select the user field and go to the events.

1. Look for the *Mscrm.userid_onchange* event handler.

   If the handler doesn't exist: 
   
   1. Add a new event of type **On Change**
   1. Select the **Scheduling/BookableResource/BookableResource_main_system_library.js** library.
   1. Enter **Mscrm.userid_onchange** in the **Function** field.
   1. Ensure the checkboxes **Enabled** and **Pass execution context as first parameter** are active.

   If the handler exists: 

   1. Edit the handler and ensure the checkboxe **Pass execution context as first parameter** is active.

1. Save and publish the updated form. 

### Update the customizations.xml file

1. Open the customizations.xml file in an editor.

1. In the *Handler* element of the *Mscrm.userid_onchange* function, ensure that the *passExecutionContext* attribute is set to **true**.

### Run a script in the browser console

To ensure this script has the permission to find and update the required information, you need to run it in a browser tab that has an active session with your enviornment. Additionally, your user account needs the permisssions to update the XML of the customized bookable resource form.

1. Open the environment in your browser. The following steps describe how to run the script in Microsoft Edge.

1. Open **DevTools** by pressing F12 or by selecting the ellipsis (&hellip;) > **More tools** > **Developer tools**

1. In **DevTools**, select the **Console** tab and select **Clear Console**.

1. Copy and paste the code below into the console window. 

1. Update the ORG constant to the URL for the environment.

1. Run the code and review the script output.

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
