# Storage Account Module

Deploys an **Azure Storage Account** into an existing resource group.

## Resources Deployed

| Resource | Type |
|----------|------|
| Storage Account | `Microsoft.Storage/storageAccounts` |

## Module Reference

```
br:ayapocacr.azurecr.io/bicepmodules/storage:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `resourceGroup().location` | Azure region for the Storage Account |
| `storageName` | string | _(required)_ | Globally unique name for the Storage Account (3–24 lowercase alphanumeric characters) |

## Usage

### Bicep

```bicep
module storage 'br:ayapocacr.azurecr.io/bicepmodules/storage:v1' = {
  name: 'storageDeploy'
  params: {
    location: resourceGroup().location
    storageName: 'mystorageaccount'
  }
}
```

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file storageAccount/default/main.bicep \
  --parameters storageAccount/poc/parameters.json
```

## Environment Parameter Files

| Environment | Parameters File | Example Values |
|-------------|-----------------|---------------|
| PoC | `poc/parameters.json` | Name: `localpocdevastorbic` |
| Dev | `dev/parameters.json` | Name: `modbicplan` |
| Int | `int/parameters.json` | Name: `modbicplan` |
| Prod | `prod/parameters.json` | Name: `modbicplan` |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/storageaccount-pipeline.yaml`. It deploys to the PoC environment using `poc/main.bicep` and `poc/parameters.json`.

## Notes

- Storage Account names must be globally unique across all Azure subscriptions.
- Names must be 3–24 characters, lowercase letters and numbers only (no hyphens).
- The module deploys with default settings; adjust redundancy (LRS, GRS, ZRS) and access tier (Hot, Cool) within the ACR-hosted module as needed.
