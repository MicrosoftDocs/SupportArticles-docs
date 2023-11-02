---
title: Troubleshoot code coverage
description: Learn how to resolve erroneous empty results messages when you expect Visual Studio to collect data for native and managed assemblies.
ms.date: 02/23/2022
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: mikejo
---
# Troubleshoot code coverage

_Applies to:_&nbsp;Visual Studio

The code coverage analysis tool in Visual Studio collects data for native and managed assemblies (_.dll_ or _.exe_ files). However, in some cases, the **Code Coverage Results** window displays an error similar to "Empty results generated: ....". This article helps you troubleshoot and resolve the various reasons why you may be encountering empty results.

## What you should see?

If you choose an **Analyze Code Coverage** command on the **Test** menu, and if the build and tests run successfully, then you should see a list of results in the **Code Coverage** window. You might have to expand the items to see the detail.

:::image type="content" source="media/troubleshooting-code-coverage/code-coverage.png" alt-text="Screenshot that shows code coverage results with coloring.":::

For more information, see [Use code coverage to determine how much code is being tested](/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested).

## Possible reasons for seeing no results or old results

### You're not using the right edition of Visual Studio

You need Visual Studio Enterprise.

### No tests were executed

**Analysis**

Check your output window. In the **Show Output from** drop-down list, choose **Tests**. See if there are any warnings or errors logged.

**Explanation**

Code coverage analysis is done while tests are running. It only includes assemblies that are loaded into memory when the tests run. If none of the tests are executed, there's nothing for code coverage to report.

**Resolution**

In Test Explorer, select **Run All** to verify that the tests run successfully. Fix any failures before using **Analyze Code Coverage**.

### You're looking at a previous result

When you modify and rerun your tests, a previous code coverage result can still be visible, including the code coloring from that old run. Follow these steps to solve the issue:

1. Run **Analyze Code Coverage**.
2. Make sure that you have selected the most recent result set in the **Code Coverage Results** window.

### .pdb (symbol) files are unavailable

**Analysis**

Open the compile target folder (typically _bin\debug_), and verify that for each assembly, there's a _.pdb_ file in the same directory as the _.dll_ or _.exe_ file.

**Explanation**

The code coverage engine requires that every assembly has its associated _.pdb_ file accessible during the test run. If there's no _.pdb_ file for a particular assembly, the assembly isn't analyzed.

The _.pdb_ file must be generated from the same build as the _.dll_ or _.exe_ files.

**Resolution**

Make sure that your build settings generate the _.pdb_ file.

- If the _.pdb_ files aren't updated when the project is built, then open the project properties, select the **Build** page, choose **Advanced**, and inspect **Debug Info**.

- In Visual Studio 2022 and later versions, for C# projects targeting .NET Core or .NET 5+, open the project properties, select the **Build** tab, choose **General**, and inspect **Debug symbols**.

- For C++ projects, ensure that the generated .pdb files have full debug information. Open the project properties and verify that **Linker** > **Debugging** > **Generate Debug Info** is set to **Generate Debug Information optimized for sharing and publishing (/DEBUG:FULL)**.

If the _.pdb_ and _.dll_ or _.exe_ files are in different places, copy the _.pdb_ file to the same directory. It's also possible to configure code coverage engine to search for _.pdb_ files in another location. For more information, see [Customize code coverage analysis](/visualstudio/test/customizing-code-coverage-analysis).

### An instrumented or optimized binary is used

**Analysis**

Determine if the binary has undergone any form of advanced optimization such as Profile Guided Optimization, or has been instrumented by a profiling tool such as _vsinstr.exe_ or _vsperfmon.exe_.

**Explanation**

If an assembly has already been instrumented or optimized by another profiling tool, the assembly is omitted from the code coverage analysis. Code coverage analysis can't be performed on such assemblies.

**Resolution**

Switch off optimization and use a new build.

### Code isn't managed (.NET) or native (C++) code

**Analysis**

Determine if you're running some tests on managed or C++ code.

**Explanation**

Code coverage analysis in Visual Studio is available only on managed and native (C++) code. If you're working with third-party tools, some or all of the code might execute on a different platform.

**Resolution**

None available.

### Project name includes 'DataCollector'

Projects that use DataCollector in the project name won't be identified by code coverage.

### Assembly has been installed by NGen

**Analysis**

Determine if the assembly is loaded from the native image cache.

**Explanation**

For performance reasons, native image assemblies aren't analyzed. For more information, see [Ngen.exe (Native Image Generator)](/dotnet/framework/tools/ngen-exe-native-image-generator).

**Resolution**

Use an MSIL version of the assembly. Don't process it with NGen.

### The custom .runsettings file has syntax issues

**Analysis**

If you're using a custom _.runsettings_ file, it might contain a syntax error. Code coverage isn't run, and either the code coverage window doesn't open at the end of the test run, or it shows old results.

**Explanation**

You can run your unit tests with a custom _.runsettings_ file to configure code coverage options. The options allow you to include or exclude files. For more information, see [Customize code coverage analysis](/visualstudio/test/customizing-code-coverage-analysis).

**Resolution**

There are two possible types of faults:

- **XML error**

  Open the _.runsettings_ file in the Visual Studio XML editor. Look for error indications.

- **Regular expression error**

  Each string in the file is a regular expression. Review each one for errors, and in particular look for:

  - Mismatched parentheses (...) or unescaped parentheses \\(...\\). If you want to match a parenthesis in the search string, you must escape it. For example, to match a function use: `.*MyFunction\(double\)`
  - Asterisk or plus at the start of an expression. To match any string of characters, use a dot followed by an asterisk: `.*`

### Custom .runsettings file with incorrect exclusions

**Analysis**

If you're using a custom _.runsettings_ file, make sure that it includes your assembly.

**Explanation**

You can run your unit tests with a custom _.runsettings_ file to configure code coverage options. The options allow you to include or exclude files. For more information, see [Customize code coverage analysis](/visualstudio/test/customizing-code-coverage-analysis).

**Resolution**

Remove all the `Include` nodes from the _.runsettings_ file, and then remove all the `Exclude` nodes. If that fixes the problem, put them back in stages.

Make sure the DataCollectors node specifies Code Coverage. Compare it with the sample in [Customize code coverage analysis](/visualstudio/test/customizing-code-coverage-analysis).

## Some code is always shown as not covered

### Initialization code in native DLLs is executed before instrumentation

**Analysis**

In statically linked native code, part of the initialization function **DllMain** and code that it calls is sometimes shown as not covered, even though the code has been executed.

**Explanation**

The code coverage tool works by inserting instrumentation into an assembly just before the application starts running. In any assembly loaded beforehand, the initialization code in **DllMain** executes as soon as the assembly loads, and before the application runs. That code appears to be not covered, which typically applies to statically loaded assemblies.

**Resolution**

None.

## References

- [Use code coverage to determine how much code is being tested](/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested)
