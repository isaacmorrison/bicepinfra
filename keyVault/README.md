# Key Vault Module

Deploys an **Azure Key Vault** into an existing resource group.

## Resources Deployed

| Resource | Type |
|----------|------|
| Key Vault | `Microsoft.KeyVault/vaults` |

## Module Reference

```
br:pocacr.azurecr.io/bicepmodules/keyvault:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `resourceGroup().location` | Azure region for the Key Vault |
| `keyvaultName` | string | _(required)_ | Globally unique name for the Key Vault (3–24 alphanumeric characters and hyphens) |

## Usage

### Bicep

```bicep
module keyvault 'br:pocacr.azurecr.io/bicepmodules/keyvault:v1' = {
  name: 'keyvaultDeploy'
  params: {
    location: resourceGroup().location
    keyvaultName: 'my-key-vault'
  }
}
```

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file keyVault/default/main.bicep \
  --parameters keyVault/poc/parameters.json
```

## Environment Parameter Files

| Environment | Parameters File | Example Values |
|-------------|-----------------|---------------|
| PoC | `poc/parameters.json` | Name: `localbicpocv` |
| Dev | `dev/parameters.json` | Name: `modbicplan` |
| Int | `int/parameters.json` | Name: `modbicplan` |
| Prod | `prod/parameters.json` | Name: `modbicplan` |
| Default | `default/parameters.json` | Name: `localbicpocv` |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/keyvault-pipeline.yaml`. It deploys to the PoC environment using `default/main.bicep` and `poc/parameters.json`.

## Notes

- Key Vault names must be globally unique across Azure.
- Soft-delete and purge protection are recommended for production Key Vaults.
- The Virtual Machine module uses a Key Vault to securely retrieve admin credentials and domain-join secrets at deployment time.
