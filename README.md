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

