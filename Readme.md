# Release Helm charts

This action can be used to update helm releases as of now.

## Inputs

See `action.yaml` to know what all inputs are required.

## Example usage

Please pay special attention to `set` input variable.

```
- uses actions-helm@master
  with:
    provider: gcp
    gcp_credentials: json_credentials_for_gcp_service_account_base64_encoded
    cluster_name: acme-cluster
    cluster_region: us-east-1a
    chart_name: stable/traefik
    version: 1.78.2
    name: traefik
    set: |
      imageTag=1.7.12
      ssl.enabled=true
      acme.enabled=true
      dashboard.enabled=true
      rbac.enabled=true
```
