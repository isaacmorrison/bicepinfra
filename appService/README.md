# App Service Module

Deploys an **Azure App Service Plan** and an **Azure Web App** (App Service) into an existing resource group.

## Resources Deployed

| Resource | Type |
|----------|------|
| App Service Plan | `Microsoft.Web/serverfarms` |
| Web App | `Microsoft.Web/sites` |

## Module Reference

```
br:pocacr.azurecr.io/bicepmodules/appservice:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `resourceGroup().location` | Azure region for all resources |
| `appServicePlanName` | string | _(required)_ | Name of the App Service Plan |
| `appServiceName` | string | _(required)_ | Name of the Web App |
| `sku` | string | _(required)_ | Pricing tier of the App Service Plan (e.g. `S1`, `P1v2`, `F1`) |
| `skuCapacity` | int | _(required)_ | Number of instances for the App Service Plan |

## Usage

### Bicep

```bicep
module appService 'br:pocacr.azurecr.io/bicepmodules/appservice:v1' = {
  name: 'appserviceDeploy'
  params: {
    location: resourceGroup().location
    sku: 'S1'
    appServiceName: 'my-web-app'
    appServicePlanName: 'my-app-plan'
    skuCapacity: 1
  }
}
```

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file appService/default/main.bicep \
  --parameters appService/poc/parameters.json
```

## Environment Parameter Files

| Environment | Parameters File | Example Values |
|-------------|-----------------|---------------|
| PoC | `poc/parameters.json` | Plan: `localmodbicplan`, App: `localisaacmodappbc2`, SKU: `S1`, Capacity: `1` |
| Dev | `dev/parameters.json` | Plan: `modbicplan` |
| Int | `int/parameters.json` | Plan: `modbicplan` |
| Prod | `prod/parameters.json` | Plan: `modbicplan` |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/appservice-pipeline.yaml`. It includes two stages:

1. **PoC** – deploys using `default/main.bicep` and `poc/parameters.json`
2. **Dev** – deploys using `dev/main.bicep` and `dev/parameters.json`

## Notes

- The `sku` parameter controls cost; use `F1` (Free) or `B1` (Basic) for non-production workloads.
- `skuCapacity` sets the number of running instances; set to `1` for dev/test environments.
