---
title: Can't create desktop flows connection from a shared canvas app
description: Provides a workaround for the flawed scenario where a canvas app embedding a desktop flows connection is shared
ms.reviewer: 
ms.author: cvassallo
author: V-Camille
ms.date: 15/03/2023
ms.subservice: power-automate-desktop-flows, power-apps-canvas
---
# Can't create desktop flows connection from a shared canvas app

This article provides a **workaround** for the flawed scenario where a **canvas app embedding a desktop flows connection is shared**. In this scenario, if the user to whom the app is shared doesn't already have a desktop flows connection already created, he will be asked to create a new one from an embbeded window in the canvas app which doesn't work properly.

_Applies to:_ &nbsp; Power Automate for desktop, Power Apps canvas
<br><br><br>

## Symptoms

Joni has been shared a Power Apps canvas app from Alex (the app embeds a desktop flows connection). It appears in her apps list : 

![list apps](media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/1-TSG-list-app.png)

>***Side note :** whether the app was shared to Joni as user or co-owner makes no difference in this scenario*


<br><br>
When Joni runs the app :
<br>
- She is asked to provide her own desktop flows connection (as she has none already created in this environment) : 

![provide desktop flows connection](media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/2-TSG-provide-connection.png)

- To do so, she clicks on sign in to create the new connection, the following form appears :

![broken desktop flows connection creation form](media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/3-TSG-faulty-form.png)

- On this form : <br><br>
   - The `Machine or machine group` field is malfunctioning as it should provide a list of user-available machines / machine groups.
   - Instead, the field behaves as a free text input, it is expecting a `machine group id` (which is not transcribed on the UI)

<br><br>
## Resolution

The workaround for this issue is to create a connection from connection page & re-open the app.

**Step-by-step workaround :**
- Close the shared app
- Open page `Connections`
- Click on `New connection`
- Select `Desktop flows`
- Create your connection (the `Machine or machine group` field is functional and provides a list of user-available devices) :
 
![healthy desktop flows connection creation form](media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/4-TSG-healthy-form.png)

- Re-open the shared app, the previously created connection is auto-selected :

![select connection](media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/5-TSG-select-connection.png)
- Click on `Allow` : you now have access to the running canvas app
