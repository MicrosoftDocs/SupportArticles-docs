---
title: Common issues of data ingestion errors or corrupt data
description: Introduces some common issues of data ingestion errors or corrupt data when using Azure Data Lake Storage or Power Query in Dynamics 365 Customer Insights - Data.
ms.date: 12/26/2023
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
---
# Common issues of ingestion errors or corrupt data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article introduces several common issues that can cause data ingestion errors in Microsoft Dynamics 365 Customer Insights - Data.

## Common issues of ingestion errors or corrupt data with Azure Data Lake Storage

During data ingestion, some of the most common issues a record might be considered corrupt include:

- The data types and field values don't match between the source file and the schema.
- The number of columns in the source file doesn't match the schema.
- Fields contain characters that cause the columns to skew compared to the expected schema. For example, incorrectly formatted quotes, unescaped quotes, newline characters, or tabbed characters.
- Partition files are missing.
- If there are `datetime`, `date`, or `datetimeoffset` columns, their format must be specified in the schema if it doesn't follow the standard format.

### Schema or data type mismatch

If the data doesn't conform to the schema, the ingestion process completes with errors.

To solve this issue, correct either the source data or the schema and re-ingest the data.

### Partition files are missing

- If the ingestion process is successful without any corrupt records, but you can't see any data, edit your *model.json* or *manifest.json* file to make sure partitions are specified. Then, [refresh the data source](/dynamics365/customer-insights/data/data-sources-manage#refresh-data-sources).

- If data ingestion occurs at the same time as data sources are being refreshed during an automatic schedule refresh, the partition files might be empty or unavailable to the system process. To align with the upstream refresh schedule, change the [system refresh schedule](/dynamics365/customer-insights/data/schedule-refresh) or the refresh schedule for the data source. Align the timing so that refreshes don't all occur at once.

### Datetime fields are in the wrong format

The `datetime` fields in the table aren't in the ISO 8601 or `en-US` format. The default `datetime` format in Dynamics 365 Customer Insights - Data is `en-US`. All the `datetime` fields in a table should be in the same format. Customer Insights supports other formats provided annotations or traits are made at the source or table level in the model or *manifest.json*. For example:

**Model.json**

```json
  "annotations": [
    {
      "name": "ci:CustomTimestampFormat",
      "value": "yyyy-MM-dd'T'HH:mm:ss:SSS"
    },
    {
      "name": "ci:CustomDateFormat",
      "value": "yyyy-MM-dd"
    }
  ]   
```

In a *manifest.json* file, the `datetime` format can be specified at the table level or attribute level. At the table level, use `"exhibitsTraits"` in the table in **.manifest.cdm.json* to define the `datetime` format. At the attribute level, use `"appliedTraits"` in the attribute in *tablename.cdm.json*.

**Manifest.json at the table level**

```json
"exhibitsTraits": [
    {
        "traitReference": "is.formatted.dateTime",
        "arguments": [
            {
                "name": "format",
                "value": "yyyy-MM-dd'T'HH:mm:ss"
            }
        ]
    },
    {
        "traitReference": "is.formatted.date",
        "arguments": [
            {
                "name": "format",
                "value": "yyyy-MM-dd"
            }
        ]
    }
]
```

**table.json at the attribute level**

```json
   {
      "name": "PurchasedOn",
      "appliedTraits": [
        {
          "traitReference": "is.formatted.date",
          "arguments" : [
            {
              "name": "format",
              "value": "yyyy-MM-dd"
            }
          ]
        },
        {
          "traitReference": "is.formatted.dateTime",
          "arguments" : [
            {
              "name": "format",
              "value": "yyyy-MM-ddTHH:mm:ss"
            }
          ]
        }
      ],
      "attributeContext": "POSPurchases/attributeContext/POSPurchases/PurchasedOn",
      "dataFormat": "DateTime"
    }
```

## Common issues of ingestion errors or corrupt data with Power Query

### Data type doesn't match the data

The most common data type mismatch occurs when a date field isn't set to the correct date format.

The data can be fixed at the source and re-ingested. Or fix the transformation within Customer Insights - Data. To fix the transformation:

1. Go to **Data** > **Data sources**.
1. Next to the data source with the corrupted data, select **Edit**.
1. Select **Next**.
1. Select each of the queries and look for the incorrect transformations applied inside the **Applied steps**, or the `date` columns that haven't been transformed with a date format.
1. Change the data type to correctly match the data.
1. Select **Save**. That data source is refreshed.
