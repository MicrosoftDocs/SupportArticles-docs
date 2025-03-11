---
title: Duplicate SLA KPI instances are being created. 
description: Provides a resolution for an issue where the duplicate service-level agreements (SLA) KPI instance are being created.
ms.reviewer: sdas, ghoshsoham
ms.author: v-heenaattar
ms.date: 11/03/2025
---

# Duplicate SLA KPI instances are being created. 

 
This article provides a resolution for an issue where the duplicate service-level agreements (SLA) KPI instance are being created. 

## Symptoms: 

	- Duplicate SLA KPI instances are seen been created during update of status of slakpiinstances or duplicate slakpiinstance are created at once. 

    - Eg., When SLA is applied to a record like Case and the SLA has one slaitem created for Resolve By KPI, then when the conditions on the Case for SLA are met only one slakpiinstance for ResolveByKPI will be created. But in some cases we see duplicate slakpiinstance for ResolveByKPI been created. 
  
## Cause: 

    - Custom logic implemented by custom plugins/workflows/flows/actions. 

## Mitigation: 

Out-of-the-box (OOB) functionality automatically creates SLA KPI instances. Hence the below customizations should be checked. 

1. Analyze Existing Customizations on OOB flows: 

	a. Review the custom logic implemented in the SLA monitoring flow and SLA item flow. 

	b. Identify redundant triggers for creating SLA KPI instances. 

2. Validate custom plugins and workflows: 

	a. Disable custom plugins and workflows and check if the issue is still a repro.  

	b. In this case custom plugins logic should be revisited and rectified. 
 
3. Privilege Misconfiguration: 

	a. Please make sure that the prerequisites for user privileges should be met as per the SLA document here:[roles](/dynamics365/customer-service/administer/define-service-level-agreements#prerequisites)

4. Ordering of SLAItems : 

	a. Ordering of SLAItems in the SLA might also cause duplication of the SLA. 

	b. In this case, slaitems causing duplicate slakpiinstance should moved at the top in the sequence in the SLA. 

 