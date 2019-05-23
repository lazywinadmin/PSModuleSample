Deploy -Name Module {
    By -DeploymentType PSGalleryModule {
        FromSource -Source .\output\PSModuleSample
        To -Targets PSGallery
        WithOptions -Options @{
            ApiKey = $env:PSGalleryKey
        }
    }
}