# PSModuleSample

PowerShell Module demo use during my presentation on Automating Module builds.

## Branches

This repository contains multiple branches to demo different approaches.

|Branch|Link|Status|Module Type|Description|
|---|---|---|---|---|
|**master**||n/a|simple psm1|just a simple module|
|**psm1_appveyor**|[link](https://github.com/lazywinadmin/PSModuleSample/blob/psm1_appveyor)|[![Build status](https://ci.appveyor.com/api/projects/status/mlidkpoq62un3uk8/branch/psm1_appveyor?svg=true)](https://ci.appveyor.com/project/lazywinadmin/psmodulesample/branch/psm1_appveyor)|simple psm1|module with appveyor|
|**psm1_appveyor_buildps1**|[link](https://github.com/lazywinadmin/PSModuleSample/tree/psm1_appveyor_buildps1)|[![Build status](https://ci.appveyor.com/api/projects/status/y6m1kbo66m5s97qq/branch/psm1_appveyor_buildps1?svg=true)](https://ci.appveyor.com/project/lazywinadmin/psmodulesample-1jfxf/branch/psm1_appveyor_buildps1)|simple psm1|module with APPVEYOR, build.ps1|
|**psm1_appveyor_release**|[link](https://github.com/lazywinadmin/PSModuleSample/tree/psm1_appveyor_release)|n/a|simple psm1|module with APPVEYOR, build.ps1, release to PSGallery|
|**psm1_appveyor_psake**|[link](https://github.com/lazywinadmin/PSModuleSample/tree/psm1_appveyor_psake)||simple psm1|module with APPVEYOR, build.ps1, Psake|
|**psm1_appveyor_deploy**|[link](https://github.com/lazywinadmin/PSModuleSample/tree/psm1_appveyor_deploy)||simple psm1|module with APPVEYOR, build.ps1, Psake, deployed to Gallery|
|**psm1_azdevops_deploy**|[link]()||simple psm1|module with AZURE DEVOPS, build.ps1, Psake, deployed to Gallery|
|**dotsource**|[link](https://github.com/lazywinadmin/PSModuleSample/tree/dotsource)||dot sourced|module dot sourced|
|**dotsource_appvey**|[link]()||dot sourced|module with APPVEYOR|
|**dotsource_appvey_buildps1**|[link]()||dot sourced|module with APPVEYOR, build.ps1|
|**dotsource_appvey_psake**|[link]()||dot sourced|module with APPVEYOR, build.ps1, Psake|
|**dotsource_appvey_deploy**|[link]()||dot sourced|module with APPVEYOR, build.ps1, Psake, deployed to Gallery|
|**dotsource_azdevops_deploy**|[link]()||dot sourced|module with AZURE DEVOPS, build.ps1, Psake, deployed to Gallery|
|**compiled_appveyor_deploy**|[link]()||compiled|module with APPVEYOR, build.ps1, Psake, BuildHelper, deployed to Gallery|
|**compiled_azdevops_deploy**|[link]()||compiled|module with AZURE DEVOPS, build.ps1, Psake, BuildHelper, deployed to Gallery|
