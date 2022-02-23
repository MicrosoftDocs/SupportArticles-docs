---
title: Troubleshoot issues related to automatic generation of contact or company-related fields
description: Learn how to troubleshoot and resolve issues with automatic generation of contact or company-related fields
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/23/2022
---

# Troubleshoot issues with automatic generation of contact or company-related fields
<a name="auto-generation-of-fields"> </a>

When you select an existing account or contact at the time of creating a new lead, the fields related to the account or contact are automatically populated. 
- For the contact-related fields to be automatically populated, the default fields such as Name, Job title, Business phone, Mobile phone, and Email must be empty.
- For the company-related fields to be automatically populated, the default fields such as Address, Website, and Company Name must be empty.

<a name="account-contact-fields-not-populating"> </a>

## Issue: Account or contact-related fields aren't populating on the Lead form.

### Solution

Verify that the On-load script in the Lead form has reference to 'LeadManagement/Lead/Lead_main_system_library.js' web resource. This web resource contains the script that automatically populates fields. If you've  customized the Lead form and used a web resource other than the out-of-the-box web resource, then this feature won't work. Contact your system administrator.

Even if you have a custom lead form, the automatic generation of fields works if the Lead form has reference to 'LeadManagement/Lead/Lead_main_system_library.js' web resource.

<a name="website-address-fields-not-populating"> </a>

## Issue: Unable to autopopulate Website and Address fields on the Lead form.

### Solution

This is by design. In the lead form, after selecting the existing account, only Company Name is autopopulated.


