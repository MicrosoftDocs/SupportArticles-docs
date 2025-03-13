---
title: 
description: 
author: 
ms.author: 
ms.reviewer: mhart
ms.date: 03/13/2025
ms.custom: sap:Schedule Board
---
# 

This article helps resolve issues ........ in Microsoft Dynamics 365 Field Service.

## Symptoms

When opening the form to create a bookable resource, the error message **Cannot read properties of undefined (reading 'getFormContext')** appears when selecting a user from the field.

## Cause

There was a change in the internal handler for the userID field. It now requires a context to be passed in from the form.

## Resolution

You can fix this through an update of the form settings in Power Apps or with a script that you run in the browser's console.

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

Edit the handler and make sure that the "Pass execution context as first parameter" is checked
Save and publish the form
