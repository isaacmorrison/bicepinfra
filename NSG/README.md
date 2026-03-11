# Network Security Group (NSG) Module

Deploys an **Azure Network Security Group (NSG)** into an existing resource group.

## Resources Deployed

| Resource | Type |
|----------|------|
| Network Security Group | `Microsoft.Network/networkSecurityGroups` |

## Module Reference

```
br:pocacr.azurecr.io/bicepmodules/nsg:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `resourceGroup().location` | Azure region for the NSG |
| `nsgName` | string | _(required)_ | Name of the Network Security Group |

## Usage

### Bicep

```bicep
module nsg 'br:pocacr.azurecr.io/bicepmodules/nsg:v1' = {
  name: 'nsgDeploy'
  params: {
    location: resourceGroup().location
    nsgName: 'my-nsg'
  }
}
```

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file NSG/default/main.bicep \
  --parameters NSG/poc/parameters.json
```

## Environment Parameter Files

| Environment | Parameters File | Example Values |
|-------------|-----------------|---------------|
| PoC | `poc/parameters.json` | Name: `demonsg` |
| Dev | `dev/parameters.json` | Name: `modbicplan` |
| Int | `int/parameters.json` | Name: `modbicplan` |
| Prod | `prod/parameters.json` | Name: `modbicplan` |
| Default | `default/parameters.json` | Name: `demonsg` |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/nsg-pipeline.yaml`. It deploys to the PoC environment using `poc/main.bicep` and `poc/parameters.json`.

## Notes

- After deploying the NSG, associate it with a subnet or network interface to enforce traffic rules.
- Security rules can be added to the NSG post-deployment via the Azure Portal, CLI, or additional Bicep templates.
- NSG flow logs can be enabled and directed to a Log Analytics Workspace or Storage Account for auditing.
