---
title: Error after planned System Maintenance
description: Provides a solution to an error that occurs after planned System Maintenance when authenticating using a custom application
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The security token could not be authenticated or authorized error occurs after planned System Maintenance when authenticating using a custom application in Microsoft Dynamics CRM 2011 Online

This article provides a solution to an error that occurs after planned System Maintenance when authenticating using a custom application in Microsoft Dynamics CRM 2011 Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2717390

## Symptoms

After Microsoft Dynamics CRM Online Planned System Maintenance, custom applications accessing the Microsoft Dynamics CRM Online 2011 Windows Communication Foundation (WCF) endpoints may fail with the exception:

> *ID3242: The security token could not be authenticated or authorized."*

## Cause

The AppliesTo property used when authenticating to the Windows LiveId Services in the Organization.svc wsdl has been changed.

## Resolution

Change the AppliesTo constant in your application to the appropriate value as given in your wsdl. For example:

It applies to the Discovery, Organization, OrganizationData services:

`https://dev.crm.dynamics.com/xrmservices/2011/discovery.svc?wsdl=wsdl1`

`https://.crm.dynamics.com/xrmservices/2011/organization.svc?wsdl=wsdl0`

`https://.crm.dynamics.com/xrmservices/2011/organizationdata.svc?wsdl=wsdl0`

Look for the property:

`<ms-xrm:AppliesTo> urn:crmna:dynamics.com </ms-xrm:AppliesTo>`

In the past, this value was `urn:crm:dynamics.com`.
