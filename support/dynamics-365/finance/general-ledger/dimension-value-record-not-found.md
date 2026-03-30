---
# required metadata
title: A financial dimension has disappeared or doesn't appear in the Financial Dimensions details page
description: Troubleshooting steps when a financial dimension is missing from the Financial Dimensions details page or shows as a custom dimension unexpectedly
author: ethanrimes
ms.date: 03/12/2026
---

# A financial dimension has disappeared or doesn't appear in the Financial Dimensions details page

This article provides troubleshooting steps when a financial dimension is missing from the **Financial Dimensions** details page, shows incorrectly as a custom dimension, or can't be added to account structures or integration formats.

## Symptoms

You might experience one or more of the following:

- A dimension no longer appears in the **Financial Dimensions** details page.
- A dimension that was previously available has disappeared.
- A dimension that should be backed by a system entity (such as Department or Project) shows as **\<Custom dimension\>** instead.
- A dimension can't be added to an account structure or integration format, even though other dimensions can.
- You receive the error: "DimensionAttributeValue.getValue called with an invalid DimensionAttribute record Id."

## Potential cause 1: A customization or extension changed the structure of a dimension's underlying view

Financial dimensions rely on underlying database views that must have an exact number of fields. If a partner solution, Independent Software Vendor (ISV), or customization added extra fields to one of these views, the system silently rejects the dimension when the server starts. This may cause some of the symptoms mentioned above.

**Resolution** - The extra fields must be removed from the affected view through a code deployment so the view structure matches what the system expects. After the corrected code is deployed and the environment restarts, the dimension reappears automatically.

For guidance on reviewing and correcting customizations, refer to [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).

## Potential cause 2: A demo model was used to create dimensions that are no longer supported

If dimensions were set up using the FleetManagement demo project (for example, Branch, Region, or RentalLocation) in a development environment, those dimensions don't work in production because the FleetManagement demo model is only available in dev environments. This leaves behind dimension data that the system can't resolve.

**Resolution** - Remove the orphaned dimension data left behind by the demo model. The [Fleet Management sample application](/dynamics365/fin-ops-core/dev-itpro/dev-tools/introduction-fleet-management-sample) is only available in development environments and shouldn't be used as a basis for production dimension configuration. Contact your system administrator or partner to clean up the FleetManagement-related dimension configuration.
