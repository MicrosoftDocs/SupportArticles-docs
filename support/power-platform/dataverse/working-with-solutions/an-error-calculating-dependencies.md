---
title: There was an error calculating dependencies for this component
description: Provides a solution to an error in which solution import failed when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# There was an error calculating dependencies for this component. Missing component id [GUID] error occurs when importing a solution into Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4463283

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The import of solution: [solution name] failed"

You may also see a reference to error code 8004F036. If you view the Detail column in the grid, you see a message such as:

> "There was an error calculating dependencies for this component. Missing component id [GUID]"

If you select **Download Log File** and view the **Components** tab in Excel, you see a message such as:

> "The dependent component SystemForm (Id=[GUID 1]) does not exist.  Failure trying to associate it with SystemForm (Id=[GUID 2]) as a dependency. Missing dependency lookup type = PrimaryKeyLookup."

## Cause

This error can occur if the solution you're importing includes a component that depends on another component, but that dependent component isn't in the solution that you're importing and doesn't exist in the target organization.

Example: You exported a solution from your development environment and tried to import it into your production environment. If the solution contains a component (ex. a system form) that references another dependent component (ex. a view or another system form), this error would occur if that dependent component isn't in the solution and not in the target organization.

The error indicates the required dependent component with an id of [GUID 1] doesn't exist in the solution or the target organization. The solution import process is trying to associate this component to an existing component [GUID 2] as a child dependency. Because component [GUID 1] doesn't exist, the association can't be made.

### Another possible cause

If you receive this type of error and the details reference Template as the dependent component, it may happen if the template was developed using a language that isn't enabled in the environment where the solution is being imported. For example: If a template was created in English, but the English language isn't enabled in the environment where you're importing the solution, it can be another cause of this error. To enable other languages, navigate to **Settings**, select **Administration**, and then select **Languages**.

## Resolution

Use one of the following options to correct this issue:

1. **Add the missing component to the target organization:**  
    Add the missing component to the target organization with a solution import.
2. **Add the missing component to the solution:**  
    If the component is in the source organization, then ensure the solution includes this component when it's created.
3. **Remove the dependency to the component:**  
    If the missing component isn't required in the target organization, then remove the component in the source and recreate the solution.

If you aren't sure which component is missing, follow these steps:

1. Unzip the solution .zip file.
2. Open the solution.xml file.
3. Copy the **GUID 1** value from the error details and search for that value within the solution.xml file. You may find a section in the XML like the following example:

    ```xml
    <MissingDependency>

    <Required key="591" type="60" displayName="[Component Name 1]" parentDisplayName="[Parent Entity]" solution="[Solution Name]" id="[GUID 1]" />

    <Dependent key="34" type="60" displayName="[Component Name 2]" parentDisplayName="[Child Entity]" id="[GUID 2]" />

    </MissingDependency>
    ```

    The XML shown above indicates the solution is missing a dependent component named [Component Name 1] with an ID of  [GUID 1]. Because this component doesn't exist within this solution, it needs to exist in the target organization to be imported successfully.

## Example resolution

Example error:

> "The dependent component SystemForm (Id=2e28cc31-d344-412d-b393-3e108b23363a) does not exist. Failure trying to associate it with SystemForm (Id=6d2cf5e0-c3bd-40fb-9842-b5c67409e23b) as a dependency. Missing dependency lookup type = PrimaryKeyLookup."

Open the solution.xml file and search for 2e28cc31-d344-412d-b393-3e108b23363a. You'll then find the following XML:

```xml
<MissingDependency>

<Required key="4" type="60" displayName="Example Dependency" parentDisplayName="Parent" solution="Active" id="{2e28cc31-d344-412d-b393-3e108b23363a}" />

<Dependent key="5" type="60" displayName="Information" parentDisplayName="Child" id="{6d2cf5e0-c3bd-40fb-9842-b5c67409e23b}" />

</MissingDependency>
```

In the example above, the solution is missing the quick view form named **Example Dependency**, which is a component of the entity named **Parent**. The entity named **Child** includes a form named **Information**. The **Information** form has a dependency on the **Example Dependency** quick view form. So the following resolutions are available:

1. Import another solution to the target organization that has **Example Dependency** quick view form for entity **Parent** before trying to import this solution.
2. Ensure that the **Example Dependency** quick view form is included in this solution, which may require the inclusion of the **Parent** entity and the required components.
3. Remove the **Example Dependency** quick view form dependency from the **Information** form of the **Child** entity in the source organization and recreate the solution.
