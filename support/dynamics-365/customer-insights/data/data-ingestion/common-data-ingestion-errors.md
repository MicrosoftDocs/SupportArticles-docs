---
title: Troubleshoot ingestion errors or corrupt data
description: Introduces common reasons for data ingestion errors or corrupt data when using Azure Data Lake Storage or Power Query in Dynamics 365 Customer Insights - Data.
ms.date: 06/03/2024
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.custom: sap:Data Ingestion\Connect to data in Azure Data Lake Storage
---
# Troubleshoot ingestion errors or corrupt data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article introduces common reasons for data ingestion errors or corrupt data when using Azure Data Lake Storage or Power Query in Microsoft Dynamics 365 Customer Insights - Data.

## Ingestion errors or corrupt data with Azure Data Lake Storage

During data ingestion, some of the most common reasons a record might be considered corrupt include:

- [The data types and field values don't match between the source file and the schema](#schema-or-data-type-mismatch).
- The number of columns in the source file doesn't match the schema.
- Fields contain characters that cause the columns to skew compared to the expected schema. For example, incorrectly formatted quotes, unescaped quotes, newline characters, or tabbed characters.
- [Partition files are missing](#partition-files-are-missing).
- [`datetime`, `date`, or `datetimeoffset` fields don't follow the standard format](#datetime-fields-are-in-the-wrong-format).

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

## Ingestion errors or corrupt data with Power Query

### Datetime values are parsed incorrectly or a parsing failure occurs 

The most common data type mismatch occurs when a date field isn't set to the correct date format. This mismatch can be caused by the incorrectly formatted source data or an incorrect [locale](/power-query/data-types#document-or-project-locale).

Symptoms of the incorrect locale issue:

- When the source data can't be parsed by the locale used, an ingestion failure occurs. For example, if "29/08/2023" is parsed with "MM/DD/YYYY," the ingestion fails because it can't parse month 29.
- When the source data is parsed successfully using an incorrect locale, the datetime values are incorrect. For example, the source data is formatted as "MM/DD/YYYY," while the default locale used to parse the data during ingestion uses "DD/MM/YYYY." As a result, "December 8, 2023" is ingested as "August 12, 2023".

  :::image type="content" source="media/common-data-ingestion-errors/power-query-date-locale-issue.png" alt-text="Screenshot shows that the datetime format is incorrect after ingestion." lightbox="media/common-data-ingestion-errors/power-query-date-locale-issue.png":::

#### Resolution

- To fix an incorrect format, update the source data and re-ingest.
- To fix an incorrect locale, change the type of all datetime fields to use the correct locale using **Change type** > **Using locale** in the Power Query transformations. For example:

  :::image type="content" source="media/common-data-ingestion-errors/change-type-using-locale.png" alt-text="Screenshot that shows how to change data type with locale in Power Query." lightbox="media/common-data-ingestion-errors/change-type-using-locale.png":::

  For more information, see [Document or project locale](/power-query/data-types#document-or-project-locale).
  
## More information

- [Connect to data in Azure Data Lake Storage](/dynamics365/customer-insights/data/connect-common-data-model)
- [Connect to a Power Query data source](/dynamics365/customer-insights/data/connect-power-query)
- [Manage data sources](/dynamics365/customer-insights/data/data-sources-manage)
