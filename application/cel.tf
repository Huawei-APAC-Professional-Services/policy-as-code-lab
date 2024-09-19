resource "kubernetes_manifest" "cel_max_replicas" {
  manifest = {
    apiVersion = "admissionregistration.k8s.io/v1"
    kind       = "ValidatingAdmissionPolicy"

    metadata = {
      name = "MaxReplicas"
    }

    spec = {
      failurePolicy = "Fail"

      matchConstraints = {
        resourceRules = [
          {
            apiGroups   = ["apps"]
            apiVersions = ["v1"]
            operations  = ["CREATE", "UPDATE"]
            resources   = ["deployments"]
          }
        ]
      }

      validations = [{
        expression = "3 <= object.spec.replicas && object.spec.replicas <= 5"
      }]
    }
  }
}

resource "kubernetes_manifest" "cel_replicas" {
  manifest = {
    apiVersion = "admissionregistration.k8s.io/v1"
    kind       = "ValidatingAdmissionPolicyBinding"

    metadata = {
      name = "ReplicasLimitationsBinding"
    }

    spec = {
      policyName        = "MaxReplicas"
      validationActions = ["Deny"]
      matchResources = {
        resourceRules = [{
          apiGroups   = ["apps"]
          apiVersions = ["v1"]
          resources   = ["deployments"]
        }]
      }
    }
  }
}