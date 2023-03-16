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

This article provides a **workaround** for the flawed scenario where a **canvas app embedding a desktop flows connection is shared**. In this scenario, if the user to whom the app is shared doesn't already have a desktop flows connection created, he will be asked to create a new one from an embbeded window in the canvas app which doesn't work properly.

_Applies to:_ &nbsp; Power Automate for desktop, Power Apps canvas
<br><br><br>

## Symptoms

Joni has been shared a Power Apps canvas app from Alex (the app embeds a desktop flows connection). It appears in her apps list : 

![image](https://user-images.githubusercontent.com/127093735/225571908-23a74444-c87b-4395-a5fb-7da1ccc7ecae.png)

>***Side note :** whether the app was shared to Joni as user or co-owner makes no difference in this scenario* A VERIFIER 


<br><br>
When Joni runs the app :
<br>
- She is asked to provide her own desktop flows connection (as she has none already created in this environment) : 

![image](https://user-images.githubusercontent.com/127093735/225574320-fce0a5d6-411a-43eb-a2d9-92eab6c371f9.png)

- To do so, she clicks on sign in to create the new connection, the following form appears :

![image](https://user-images.githubusercontent.com/127093735/225596681-acf17894-350c-46ef-b87a-ced3eac14535.png)

- On this form : <br><br>
   - The `Machine or machine group` field is malfunctioning as it should provide a list of user-available machines / machine groups.
   - Instead, the field behaves as a free text input, it is expecting a `machine group id` (which is not transcribed on the UI)

<br><br><br>
## Resolution

The workaround for this issue is to create a connection from connection page & re-open the app.

**Step-by-step workaround :**
- Close the shared app
- Open page `Connections`
- Click on `New connection`
- Select `Desktop flows`
- Create your connection (the `Machine or machine group` field is functional and provides a list of user-available devices) :
 
![image](https://user-images.githubusercontent.com/127093735/225597302-91d8b749-266d-4664-84aa-5c363515c9e3.png)

- Re-open the shared app, the previously created connection is auto-selected :

![image](https://user-images.githubusercontent.com/127093735/225595289-bb7a3625-560f-4c7e-810b-13574652b0ed.png)
- Click on `Allow`: you know have access to the running canvas app
