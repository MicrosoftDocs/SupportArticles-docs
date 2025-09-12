---
title: Order taker not auto-filled when creating purchase or sales orders
description: Steps to troubleshoot when the Order taker or Sales orderer field is not automatically populated while creating purchase or sales orders in Microsoft Dynamics 365 Supply Chain Management.
author: vermayashi
ms.date: 09/12/2025
ms.search.form: PurchTable, PurchTablePart, PurchCreateOrder, SalesTable, SalesCreateOrder
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: vermayashi
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with order processing
---
# Order taker not being auto-filled when creating purchase or sales orders

## Symptoms  
When creating a purchase order (PO) or sales order (SO), the **Order taker** (or **Sales orderer**) field isn’t automatically populated.  

## Cause  
The issue occurs when the user account isn’t associated with a **PartyID** that has the **Worker role** in the current legal entity.  

- The system requires a Worker role to automatically populate the **Order taker / Sales orderer** field.  
- If a user has multiple PartyIDs, only the one with the Worker role for the current legal entity enables auto-fill.  
- If no Worker record exists for the person in this legal entity, the auto-fill won’t trigger.  

## Resolution  
To resolve this issue, associate the user with the PartyID that has the **Worker role** for the current legal entity.  

### Steps to fix  

1. **Confirm the issue**  
   - In the target legal entity, create a new PO or SO and verify that the **Order taker / Sales orderer** field is blank.  

2. **Check the party record**  
   - Go to **Organization administration > Global address book**.  
   - Search for and open the relevant person/party record.  
   - In the record, check the **Roles** (or role-specific pages) to confirm whether this PartyID has the **Worker role assigned for the current legal entity**.  

3. **If no Worker role exists**  
   - Go to **Human resources > Workers > Workers**.  
   - Select **New** to create a worker.  
   - Enter the hire date and required details.  
   - This action creates/associates the PartyID with the **Worker role** in the current legal entity.  

4. **Associate the user account**  
   - Go to **System administration > Users > Users**.  
   - Open the user account.  
   - In the **Person** (or Contact) field, link the user to the party record that has the Worker role for the current legal entity.  
   - If the Person field is locked due to an older association, use **Maintain versions** to remove the existing relation, then assign the correct Worker-linked party.  

5. **Validate the fix**  
   - Save the user record.  
   - Create a new PO and SO again. The **Order taker / Sales orderer** field should now be auto-filled correctly.  

## More information  
If the issue persists after confirming the Worker role association, check for duplicate PartyIDs, customizations that override defaults, or capture a trace for further support investigation.  

## Keywords  
Order taker blank, Sales orderer not auto-filled, Worker role missing, Purchase order, Sales order, Dynamics 365 SCM, PartyID association, User setup, Auto-fill not working  

## Related links  
- [Global address book overview](https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/organization-administration/overview-global-address-book)  
- [Manage users](https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/fin-ops/sysadmin/create-new-users)  
