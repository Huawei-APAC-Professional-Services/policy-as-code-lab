# policy-as-code-lab

## Creating Backend for terraform
In this workshop, Huawei Cloud OBS is used as the backend of terraform

1. Log into [Huawei Cloud](https://www.huaweicloud.com/) using the account provided by the organizer.

2. On the console, search the `OBS` service in the search box and select the `Object Storage Service`
![SearchOBS](./resources/1-searchbar.png)

![SelectOBS](./resources/1-searchbar-1.png)

3. On the `Object Storage Service` page, Click `Create Bucket` button on the top right corner of the page
![CreateBucket1](./resources/2-Createobsbucket-1.png)

4. On the bucket creation page, only need to provide a uniq bucket name and leave other parameters unchanged
![CreateBucket2](./resources/2-Createobsbucket-2.png)

## Create AK/SK
1. Log into [Huawei Cloud](https://www.huaweicloud.com/) using the account provided by the organizer.

2. On the top right corner of the page, Click the `Account Name` and Select `My Credentials`
![CreateAK1](./resources/3-Createsk-1.png)

3. On the Credentials page, select `Access Keys` from the panel on the left side of the page and Click `Create Access Key`
![CreateSK2](./resources/3-Createsk-2.png)

4. After the Access Key is created, download the key to your desktop
![CreateAK3](./resources/3-Createsk-3.png)

## Create Code Repo
1. Log into [Huawei Cloud](https://www.huaweicloud.com/) using the account provided by the organizer.

2. On the console, search the `CodeArts` service in the search box and select the `CodeArts`
![CreateRepo](./resources/4-Createcodearts-1.png)

3. On the `CodeArts` Page, Click `Access Service` on the top right corner of the page
![CreateRepo1](./resources/4-Createcodearts-2.png)

4. On the Service page, Select `Scrum` template to create a project
![CreateProject](./resources/4-Createcodearts-3.png)

5. On the Creation Page, You only need to change the `Name`
![CreateProject1](./resources/4-Createcodearts-4.png)

6. On the newly created project page, Select `Code` -> `Repo`
![CreateProject2](./resources/4-Createcodearts-5.png)

7. On the `Repo` page, Click `New Repository` to create a Repo
![CreateRepo](./resources/4-Createcodearts-6.png)

8. Select `Import` as `Repository Type`
![CreateRepo1](./resources/4-Createcodearts-7.png)

9. Select `Import From` as `Git Url` and Use the repository url: ```https://github.com/Huawei-APAC-Professional-Services/policy-as-code-lab.git```
![CreateRepo2](./resources/4-Createcodearts-8.png)

10. In the next step. keep the information as it appears and Click `Ok`
![CreateRepo3](.//resources/4-Createcodearts-9.png)

## Update Codes
1. On the `Code` page, Select `Infrastructure` folder
![UpdateCodes](./resources/5-updatecodes-1.png)

2. Find the `provider.tf` file in the folder and Click `Edit`
![ChangeProvider](./resources/5-updatecodes-2.png)

![ChangeProivder](./resources/5-updatecodes-3.png)

3. Update the Terraform backend configuration by providing the name of the bucket you created in [Creating Backend for terraform](#creating-backend-for-terraform)
![UpdateProvider1](./resources/5-updatecodes-4.png)

4. Select the `Application` folder and `Edit` `provider.tf` file
![UpdateProvider2](./resources/5-updatecodes-5.png)

5. Update the Terraform backend configuration and remote data by providing the name of the bucket you created in [Creating Backend for terraform](#creating-backend-for-terraform)
![UpdateRepo33](./resources/5-updatecodes-6.png)

![UpdateRepo34](./resources/5-updatecodes-7.png)

## Creating Service Endpoint
1. On the top right corner of the CodeArts service, Click the profile icon and Select `This Account Settings`
![EndPoints](./resources/6-pipeline-3.png)

2. On the left side panel, Select `Repo` -> `HTTPS Password`
![Endpoints1](./resources/6-pipeline-4.png)

3. Change the `HTTPS Password` to `Use Huawei Cloud login password` if it's not the value and Copy the username
![Endpoints2](./resources/6-pipeline-5.png)

4. Go back to project page and Select `Settings` -> `General` on the left side panel
![Endpoints3](./resources/6-pipeline-6.png)

5. On the new page, Select `Service Endpoints` -> `CodeArts Repo HTTPS`
![Endpoints44](.//resources/6-pipeline-7.png)

6. Provide the following information for creating Endpoint
   * Service Endpoint Name: any
   * CodeArts Repo URL: You can copy it from repository information
   * Username: Copied value from step 3
   * Password: The password provided by Organizer
![Endpoints5](./resources/6-pipeline-8.png)

## Creating Terraform Validation Job
1. On the `CodeArts` service page, Select `CICD` -> `Build` -> `Create Task`
![CreateTerraformValidation](./resources/7-terraformvalidation-1.png)

2. On the creation page, use `terrafrom-validation` and click `Next` and Select `Shell` template
![CreateTerraformValidation1](./resources/7-terraformvalidation-2.png)
![CreateTerraformValidation2](./resources/7-terraformvalidation-3.png)

3. On the task page, Click `...` on the right of job name and Select `Delete` to delete the job
![CreateTerraformValidation2](./resources/7-terraformvalidation-4.png)

4. On the left side panel, Click `Add Build Actions` to add a new action, in the action list, Select `Use SWR Public Image`
![CreateTerraformValidation3](./resources/7-terraformvalidation-5.png)

5. Provide the following parameters for the job
   * `Action Name`: ```Terrafrom Validation```
   * `Image Address`: ```swr.ap-southeast-3.myhuaweicloud.com/core/ubuntu:codearts1```
   * `Commands`:
      ````
      export HW_ACCESS_KEY=${HW_ACCESS_KEY}
      export HW_SECRET_KEY=${HW_SECRET_KEY}
      export AWS_ACCESS_KEY_ID=${HW_ACCESS_KEY}
      export AWS_SECRET_ACCESS_KEY=${HW_SECRET_KEY}
      terraform -chdir=infrastructure init
      terraform -chdir=infrastructure validate
      terraform -chdir=application init
      terraform -chdir=application validate
      ```
![CreateTerraformValidation4](./resources/7-terraformvalidation-6.png)

6. Select the `Parameters` tab on the top of the page and Create the following two parameters with empty value and enable the `Runtime Settings`
   * Name: `HW_ACCESS_KEY`
   * Name: `HW_SECRET_KEY`
![CreateTerraformValidation5](./resources/7-terraformvalidation-7.png)

7. Save the task

## Creating Checkov Validation Job
1. On the `CodeArts` service page, Select `CICD` -> `Build` -> `Create Task`
![CreateTerraformValidation](./resources/7-terraformvalidation-1.png)

2. On the creation page, use `checkov-validation` and click `Next` and Select `Shell` template
![checkov1](./resources/8-checkovvalidation-1.png)
![checkov2](./resources/8-checkovvalidation-2.png)

3. On the task page, Click `...` on the right of job name and Select `Delete` to delete the job
![checkov3](./resources/8-checkovvalidation-3.png)

4. On the left side panel, Click `Add Build Actions` to add a new action, in the action list, Select `Use SWR Public Image`
![checkov4](./resources/8-checkovvalidation-4.png)

5. Provide the following parameters for the job
   * `Action Name`: ```Checkov Validation```
   * `Image Address`: ```swr.ap-southeast-3.myhuaweicloud.com/core/ubuntu:codearts1```
   * `Commands`:
      ````
      checkov -d infrastructure --download-external-modules true --external-checks-git https://github.com/Huawei-APAC-Professional-Services/terraform-policy.git
      checkov -d application --download-external-modules true --external-checks-git https://github.com/Huawei-APAC-Professional-Services/terraform-policy.git
      ```
6. Save the task

## Creating Terraform Plan Job
1. On the `CodeArts Build` Page, Click the `...` icon on the `terraform-validation` job to Clone a new job
![Terraformplaninfra](./resources/9-infraterraformplan-1.png)

2. Select `Basic Information` tab on the top of the page and Change the name to `terrafrom-plan`
![Terraformplaninfra1](./resources/9-infraterraformplan-2.png)

3. Select the `Build Actions` tab and the `Terrafrom Validation` job on the left side panel and Change the following the following parameters for the job
   * `Action Name`: ```Terrafrom Plan```
   * `Image Address`: ```swr.ap-southeast-3.myhuaweicloud.com/core/ubuntu:codearts1```
   * `Commands`:
      ````
      export HW_ACCESS_KEY=${HW_ACCESS_KEY}
      export HW_SECRET_KEY=${HW_SECRET_KEY}
      export AWS_ACCESS_KEY_ID=${HW_ACCESS_KEY}
      export AWS_SECRET_ACCESS_KEY=${HW_SECRET_KEY}
      terraform -chdir=infrastructure init
      terraform -chdir=infrastructure plan
      terraform -chdir=application init
      terraform -chdir=application plan
      ```
![terrafromplan4](./resources/9-infraterraformplan-3.png)
4. Save the task

## Creating Terraform Apply Job
1. On the `CodeArts Build` Page, Click the `...` icon on the `terraform-validation` job to Clone a new job
![Terraformplaninfra](./resources/9-infraterraformplan-1.png)

2. Select `Basic Information` tab on the top of the page and Change the name to `terrafrom-apply`
![Terraformapply](./resources/10-infraterraappy-1.png)

3. Select the `Build Actions` tab and the `Terrafrom Validation` job on the left side panel and Change the following the following parameters for the job
   * `Action Name`: ```Terrafrom Apply```
   * `Image Address`: ```swr.ap-southeast-3.myhuaweicloud.com/core/ubuntu:codearts1```
   * `Commands`:
      ````
      export HW_ACCESS_KEY=${HW_ACCESS_KEY}
      export HW_SECRET_KEY=${HW_SECRET_KEY}
      export AWS_ACCESS_KEY_ID=${HW_ACCESS_KEY}
      export AWS_SECRET_ACCESS_KEY=${HW_SECRET_KEY}
      terraform -chdir=infrastructure init
      terraform -chdir=infrastructure apply -auto-approve
      terraform -chdir=application init
      terraform -chdir=application apply -auto-approve
      ```
![terraformplan1](./resources/10-infraterraappy-2.png)
4. Save the task

## Creating Deployment Pipeline
1. On the `CodeArts` service page, Select `CICD` -> `Pipeline`
![Pipeline](./resources/6-pipeline-1.png)

2. On the `Pipeline` page, Click `Create Pipeline` button
![Pipeline1](./resources/6-pipeline-2.png)

3. Providing the information to create pipeline
![Pipeline2](./resources/6-pipeline-9.png)

4. Select a `Blank Template` for this pipeline
![Pipeline3](./resources/6-pipeline-10.png)

5. After the pipeline is created, Select `Parameter Configurations` on the top of page
![Pipeline4](./resources/6-pipeline-11.png)

6. Set the following parameters with the credentials created in [Create AK/SK](#create-aksk)
```HW_ACCESS_KEY``` 
```HW_SECRET_KEY```

![Pipeline5](./resources/6-pipeline-12.png)

![Pipeline6](./resources/6-pipeline-13.png)

7. Change to `Task Orchestration` tab and click `Edit` icon to modify the stage name to `Validation`
![Pipeline7](./resources/6-pipeline-14.png)

![Pipeline8](./resources/6-pipeline-15.png)

8. Click `New Job` to create a build job, for the job type, select `Build`
![Pipeline16](./resources/6-pipeline-16.png)

9. On the job configuration page, select the `terraform-validation` task and `policy-as-code-lab` repository, for the following parameters, using the following values.
   * Name: `terraform validation`
   * HW_ACCESS_KEY: `${HW_ACCESS_KEY}`
   * HW_SECRET_KEY: `${HW_SECRET_KEY}`
![pipelinevalidation1](./resources/6-pipeline-17.png)

10. On the pipeline page, Click `+Parallel Job` to add another job under `Validation` stage
![pipelinevalidation2](./resources/6-pipeline-18.png)

11. On the job configuration page, providing the following parameters:
   * Name: `checkov validation`
   * Select Task: `checkov-validation`
   * Repository: `policy-as-code-lab`
![pipelinevalidation3](./resources/6-pipeline-19.png)

12. On the pipeline configuration page, Click `+Stage` to create a `Plan` stage
![pipelinevalidation3](./resources/6-pipeline-20.png)

![pipelinevalidation4](./resources/6-pipeline-21.png)

13. Under the `Plan` stage, add a `terraform plan` job, to configure the job with the following parameters:
   * Name: `terraform plan`
   * Select Task: `terraform-plan`
   * Repository: `policy-as-code-lab`
   * HW_ACCESS_KEY: `${HW_ACCESS_KEY}`
   * HW_SECRET_KEY: `${HW_SECRET_KEY}`

![pipelinevalidation5](./resources/6-pipeline-22.png)

14. On the pipeline configuration page, Click `+Stage` to create a `Deployment` stage
![pipelinevalidation3](./resources/6-pipeline-23.png)

15. Under the `Deployment` stage, add a `terraform apply` job, to configure the job with the following parameters:
   * Name: `terraform apply`
   * Select Task: `terraform-apply`
   * Repository: `policy-as-code-lab`
   * HW_ACCESS_KEY: `${HW_ACCESS_KEY}`
   * HW_SECRET_KEY: `${HW_SECRET_KEY}`
![pipelinevalidation3](./resources/6-pipeline-24.png)

16. On the pipeline page, Click `Save and Execute` to run the pipeline
![pipelinevalidation3](./resources/6-pipeline-25.png)

![pipelinevalidation3](./resources/6-pipeline-26.png)

