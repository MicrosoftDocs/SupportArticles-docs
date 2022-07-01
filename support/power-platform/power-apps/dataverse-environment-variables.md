---
title: Data source references based on environment variables are not updated during solution import to another environment
description: Describes an issue when after importing a solution to a different environment, data source references based on environment variables are not updated.
ms.reviewer: tapanm
ms.topic: troubleshooting
ms.date: 6/30/2022
author: simonxjx
ms.author: lanced
ms.subservice: powerapps-others
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - lancedMicrosoft
  - tapanm-msft
---

# Data source references based on environment variables are not updated during solution import to another environment

## Symptoms

References to data sources are not updated when importing a Power Apps solution into a different environment. Depending on the cause, the app may continue to run correctly though Power Apps Studio does not reflect the correct references. However, Power Apps Studio may not reflect the correct references in the target environment.

## Cause

There are several possible causes.

1. Data source environment variables are dynamically retrieved for a data source at play/runtime. For performance reasons, once retrieved, environment variable values are cached locally in the browser. Values may take up to an hour to auto-refresh.

1. A missing current value. A default value will be used if no 'current' value is available.

1. SharePoint does not fully support ALM scenarios and there are issues in correctly updating the references to SharePoint in the environment where the solution is imported. This means that SharePoint meta-data (for example, a new column has been added) or data source info (for example, a list pointed at) will be wrong. Refreshing Power Apps studio in the target environment will not get additional metadata and the data source will always point to the data source for the source environment.

When the source environment uses exactly the same URL for two or more lists, the target environment incorrectly collapses the URLs into a single value.

Working example:

In this example, the environment variables work correctly. Note that SPURL1 is intended to be paired with List 1 and SPURL2 is intended to be paired with List 2. Data source environment variables 'ABC' and 'DEF' are different.

| Data source</br>Environment variable | Source Value | Target Value |
|-------------------------|-------------------------|-------------------------|
| SPURL1 | ABC | XYZ |
| SPURL2 | DEF | LMN |
| LIST1 | List 1 | List 1 |
| LIST2 | List 2 | List 2 |

Non-working example:

When data source environment variables for SPURL1 and SPURL2 ( 'GHI and 'GHI') are the same, they collapse into the single 'OPQ' value on import. Even though the intended values were 'OPQ'and 'RST'.

| Data source</br>Environment variable | Source Value | Intended Target Value | Actual Target Value |
|-------------------------|-------------------------|-------------------------|-------------------------|
| SPURL1 | GHI | OPQ | OPQ |
| SPURL2 | GHI | RST | OPQ |
| LIST1 | List 1 | List 1 | List 1 |
| LIST2 | List 2 | List 2 | List 2 |

### Legacy causes.

Issues with SharePoint choice columns have been fixed and deployed by the end of April 2022.

## Resolution

Review the Environment variables [documentation](https://docs.microsoft.com/power-apps/maker/data-platform/environmentvariables). Use [Monitor](https://docs.microsoft.com/power-apps/maker/monitor-overview) to investigate environment variable issues to verify if the data calls are connecting to the correct dataset or list. Lists created using Microsoft Lists are internally identified by a unique ID/GUID. You can find this value in using a trace inside Monitor. Use this value to trace what lists are being used, and where.

### To avoid locally cached values that may be out of date

1. Test your solution with a new browser instance. Close all browser windows to ensure you have cleared all cached values. Environment variable values are cached at multiple levels to improve performance. Testing with a new browser instance will ensure you are not using older cached values.

1. Try reexporting/importing again. This action refreshes your data sources and environment variables.

### To avoid using a default value when a current value should be used

Check to see if you need a default value and if you are getting prompted for a current value. In most ALM scenarios, you do not need a default value unless you plan to have a default value for all environments. You won't be prompted to provide a value during the import process when you only have the default value set.

### To avoid issues with SharePoint metadata in the target environment

1. Do not rely on Power Apps Studio for info in the target environment. The runtime will be using the correct values. If you need to double check, you can use a Monitor trace.

1. Do not rely on the data source info flyout for information about what the data source is pointing to. The runtime will use correct information. To verify, you can use a Monitor trace.

1. When you want to take advantage of a change in a list (such as when using a new column), update the solution in the source environment and re-import to the target environment.

### To avoid issues with multiple SharePoint URLs in the same solution

If you want the target solution to reference different SharePoint URLs in different environments then mirror that structure in your source environment. Create separate lists so that the migration process references correct values.

To avoid issues with SharePoint data source overrides that may not be defined correctly

When adding a SharePoint data source to the canvas app, ensure that the site and lists are picked from under the Advanced section of Power Apps Studio. The advanced section shows the existing environment variables defined in your environment.
