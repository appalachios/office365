###############################################
#Administer Licensing in Office 365           #
#Version: 1.4                                 #
#Latest update: 29MAR2017                     #
#                                             #
#                                             #
#Note: change TENANTNAME to match your        #
#      tenant domain, where applicable        #
#                                             #
###############################################

#Get list of all SKUs
Get-MsolAccountSku


#Get a list of all users with a specified License SKU and export to CSV file in the current directory
#In this example, we are using the Azure Active Directory Premium license
Get-MsolUser -all | where {$_.Licenses.AccountSKUID -eq "Contoso:AAD_PREMIUM"} | Select-Object Userprincipalname, Displayname, Licenses | Export-Csv usersWithCertainLicense.csv


#Remove all AAD Premium licenses from users that have them
Get-MsolUser -all | where {$_.Licenses.AccountSKUID -eq "Contoso:AAD_PREMIUM"} | Set-MsolUserLicense -RemoveLicenses "Contoso:AAD_PREMIUM"


#Add EMS licenses to all users that have E3 (ENTERPRISEPACK) licenses
Get-MsolUser -all | where {$_.Licenses.AccountSKUID -eq "Contoso:ENTERPRISEPACK"} | Set-MsolUserLicense -AddLicenses "Contoso:EMS"
