# Solutions
Policy-as-code is a method of defining and managing security rules, criteria, and conditions through code. It is a way of enforcing security and risk policies programmatically, within a continuous integration/continuous delivery/continuous deployment (CI/CD) pipeline. 

The Policies usually represent the best practices or regulation and organization requirement which is unlikely to be changed frequently. So when the pipeline is aborted by policy checking, it usually means that we need to modify our codes to make it conform to the policy.

Without specific elaboration, the following updates are all made in the `policy-as-code-lab` repo

1. Open the `main.tf` file under `Infrastructure` folder. Click `Edit` icon to change the value of `source` parameter of `core_network` module to the following 
```
git::https://github.com/Huawei-APAC-Professional-Services/terraform-module.git//vpc?ref=3066f775dc65dd382b9f60262cc6a1be0df15d1f
```

![ChangeSource](./resources/12-solution-2.png)

2. Open the `terraform.tfvars` file under `Infrastructure` folder. Click `Edit` icon to change the value of `eip_bandwidth` to 150
![FixTerraformValidation](./resources/12-solution-1.png)


3. Open the `provider.tf` file under `Infrastructure` folder. Click `Edit` icon to change `region` parameter to `ap-southeast-3` 
![FixTerraformValidation](.//resources/12-solution-6.png)

4. Open the `main.tf` file under `Infrastructure` folder. Click `Edit` icon to add `tags` parameter to `kube_eip` resources

```
tags = {
  CostCenter = "10010"
}
```
![ChangeTags](./resources/12-solution-3.png)

5. Open the `main.tf` file under `Infrastructure` folder. Click `Edit` icon to add `tags` parameter to `huaweicloud_cce_cluster.main` resource
```
tags = {
  CostCenter = "10010"
}
```
![ChangeTags1](./resources/12-solution-5.png)

