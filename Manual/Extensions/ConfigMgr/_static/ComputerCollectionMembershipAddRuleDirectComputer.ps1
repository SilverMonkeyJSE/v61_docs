$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ConfigMgrConnectionSettings = New-Object SIM.ConfigMgr.ConnectionSettings
$ConfigMgrConnectionSettings.WMIHostName = 'localhost'
$ConfigMgrConnectionSettings.SiteCode = 'SIM'
$ConfigMgrConnectionSettings.SQLHostname = $ConfigMgrConnectionSettings.WMIHostName;

$ConfigMgrConnection = New-Object SIM.ConfigMgr.Connection($ConfigMgrConnectionSettings)

$res = New-Object Base.Result("Starting ConfigMgr script...")

$res.ChildAdd($ConfigMgrConnection.Connect())

if ($res.Successful -eq $true)
            
{

    $ConfigMgrComputersObject = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)

    $objParametersCollectionMembership = New-Object SIM.ConfigMgr.ParametersCollectionMembership;

    $objParametersCollectionMembership.CollectionMembershipType = [SIM.ConfigMgr.ParametersCollectionMembership+CollectionMembershipTypes]::RuleDirectComputer;
    $objParametersCollectionMembership.CollectionName = "ParentColl";
    $objParametersCollectionMembership.ResourceName = "TestComputer478";

    $res.ChildAdd($ConfigMgrComputersObject.CollectionMembershipAdd($objParametersCollectionMembership));
}

$res.Dump()

