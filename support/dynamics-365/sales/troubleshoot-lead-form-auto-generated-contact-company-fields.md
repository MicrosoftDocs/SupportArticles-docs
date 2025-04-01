---
title: Troubleshoot issues with automatic creation of contact or company-related fields
description: Provides resolutions for the issues with automatic generation of contact or company-related fields in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/28/2022
ms.custom: sap:Lead
---

# Troubleshoot issues with automatic generation of contact or company-related fields

When you select an existing account or contact at the time of creating a new lead, the fields related to the account or contact are automatically populated.

- For the contact-related fields to be automatically populated, the default fields such as Name, Job title, Business phone, Mobile phone, and Email must be empty.
- For the company-related fields to be automatically populated, the default fields such as Address, Website, and Company Name must be empty.

## Issue 1 - Account or contact-related fields aren't populated on the Lead form

### Resolution

Verify that the On-load script in the Lead form has reference to *LeadManagement/Lead/Lead_main_system_library.js* web resource. This web resource contains the script that automatically populates fields. If you've customized the Lead form and used a web resource other than the out-of-the-box web resource, then this feature won't work. Contact your system administrator.

Even if you have a custom lead form, the automatic generation of fields works if the Lead form has reference to *LeadManagement/Lead/Lead_main_system_library.js* web resource.

## Issue 2 - Website and Address fields aren't populated on the Lead form

### Resolution

This is by design. In the lead form, after selecting the existing account, only Company Name is autopopulated.
