# Log Analytics Module

Deploys an **Azure Log Analytics Workspace** into an existing resource group.

## Resources Deployed

| Resource | Type |
|----------|------|
| Log Analytics Workspace | `Microsoft.OperationalInsights/workspaces` |

## Module Reference

```
br:ayapocacr.azurecr.io/bicepmodules/loganalytics:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `resourceGroup().location` | Azure region for the workspace |
| `logAnalyticsWorkspaceName` | string | _(required)_ | Name of the Log Analytics Workspace |

## Usage

### Bicep

```bicep
module loganalytics 'br:ayapocacr.azurecr.io/bicepmodules/loganalytics:v1' = {
  name: 'loganalyticsdeploy'
  params: {
    location: resourceGroup().location
    logAnalyticsWorkspaceName: 'my-log-analytics-workspace'
  }
}
```

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file LogAnalytics/default/main.bicep \
  --parameters LogAnalytics/poc/parameters.json
```

## Environment Parameter Files

| Environment | Parameters File | Example Values |
|-------------|-----------------|---------------|
| PoC | `poc/parameters.json` | Name: `localayapoclaw` |
| Dev | `dev/parameters.json` | Name: `ayapoclaw` |
| Int | `int/parameters.json` | Name: `ayapoclaw` |
| Prod | `prod/parameters.json` | Name: `modbicplan` |
| Default | `default/parameters.json` | Name: `ayapoclaw` |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/loganalytics-pipeline.yaml`. It deploys to the PoC environment using `poc/main.bicep` and `poc/parameters.json`.

## Notes

- Log Analytics Workspaces can serve as a central destination for diagnostic logs from other Azure resources (VMs, App Services, Key Vaults, etc.).
- The default data retention period is 30 days; this can be adjusted in the module parameters.
- Workspace names must be unique within a resource group and between 4–63 characters.
