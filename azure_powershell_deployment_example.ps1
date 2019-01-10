
#microsoft Example
New-AzureRmResourceGroupDeployment `
    -Name ExampleDeployment `
    -ResourceGroupName ExampleResourceGroup `
    -TemplateFile c:\MyTemplates\storage.json `
    -TemplateParameterFile c:\MyTemplates\storage.parameters.json


#To test your template and parameter values without actually deploying any resources
#No output means no errors or syntax issues
Test-AzureRmResourceGroupDeployment `
    -ResourceGroupName "MyResourceGroup" `
    -TemplateFile template.json `
    -TemplateParameterFile parameters.json


#To run a real deployment. CD into directory with template.json & parameters.json
New-AzureRmResourceGroupDeployment `
    -Name "USWEST2VMDeployment" `
    -ResourceGroupName "MyResourceGroup" `
    -TemplateFile template.json `
    -TemplateParameterFile parameters.json


