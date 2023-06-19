---
title: Forms show an error about being read-only
description: Resolve issues with read-only forms in Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Forms show an error about being read-only

This article helps resolve issues an error message on forms.

## Symptoms

Forms show the error message: "Error message: "This form can only be used on service-maintenance based records. Record is read only."

## Resolution

Field Service makes the out-of-the-box Field Service opportunity, lead, quote, and invoice forms read-only once Field Service detects the record is not a service-maintenance based record. Field Service forms or the forms copied from Field Service forms do not support opportunity, lead, quote, and invoice records other than Field Service opportunity, lead, quote, and invoice.

To use an opportunity form for non-Field Service-related opportunities, use the out-of-the-box opportunity (**Opportunity: Opportunity**) form or create a copy of the Field Service form for further customization. The same applies for the Field Service forms for lead, quote, and invoice.
