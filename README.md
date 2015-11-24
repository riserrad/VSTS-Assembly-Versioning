## Assembly Versioning for Build vNext

This is a custom vNext build task to perform automatic Assembly Versioning in **Visual Studio Team Services** (aka Visual Studio Online) or Team Foundation Server 2015.

It basically lists all the AssemblyInfo files in your source folder and then edit each one of them to replace the two attributes values, from AssemblyInfo and AssemblyFileInfo, with the one built by this task.
### How does this task build the version number?

The task asks for two of the four numbers (to know more about assembly versioning, please refer to [this link](https://msdn.microsoft.com/en-us/library/51ket42z(v=vs.110).aspx)), the **Major** and the **Minor** numbers:

![alt text](https://raw.githubusercontent.com/ricardoserradas/VSTS-Assembly-Versioning/master/images/BuildTaskSample.png "This is the Build Task properties")

The **Build number** is the Julian Day.

The **Revision number** is the sequential number of the build in the day.

**Important**: If you are using this build task, please keep the **Build number format**, defined in General settings, *as is*. Otherwise, the build will not be able to detect the revision number. See below:

![alt text](https://raw.githubusercontent.com/ricardoserradas/VSTS-Assembly-Versioning/master/images/GeneralProperties_Revision.png "The General properties")
