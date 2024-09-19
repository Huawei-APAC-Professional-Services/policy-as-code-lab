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
```AWS_ACCESS_KEY_ID``` 
```AWS_SECRET_ACCESS_KEY```
```HW_ACCESS_KEY``` 
```HW_SECRET_KEY```

![Pipeline5](./resources/6-pipeline-12.png)

![Pipeline6](./resources/6-pipeline-13.png)

7. Change to `Task Orchestration` tab and click `Edit` icon to modify the state name to `Validation`
![Pipeline7](./resources/6-pipeline-14.png)

![Pipeline8](./resources/6-pipeline-15.png)

8. Click `New Job` to create a build job
![Pipeline9]