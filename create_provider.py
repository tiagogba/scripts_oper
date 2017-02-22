import time as systime

##Var Config provider
realmName = 'myrealm'
ldapProviderName = 'Nome_do_provider' 
groupBaseDN = 'xxxx'
userBaseDN = 'xxxx'
ldapPrincipal = 'xxx';
ldapHost = 'xxxxxxxxxxx';
ldapAdminPassword = 'xxxx'
userNameAttribute = 'xxx'
groupFromNameFilter = '(xxxxx'
staticGroupObjectClass = 'xxxxx'
staticMemberDnAttribute = 'xxxxx'
staticGroupDNsfromMemberDNFilter ='xxxx'


print('-------------------------CONFIGURADOR LDAP OUD LIVELO----------------------------')
print('---------------------------------------------------------------------------------')
systime.sleep(10)

##Conectando
connect('usuario','senha','t3://127.0.0.1:7001')
domainConfig()
print('-------------------------Connected----------------------------')
print('----------------------------------------------------------------------------')
##Trocando o autenticador para modo sufficient
print('Trocando DefaultAutheticator para Sufficient')
print('----------------------------------------------------------------------------')
edit()
startEdit()
cd('/SecurityConfiguration/' + domainName + '/Realms/' + realmName)
cd('/SecurityConfiguration/' + domainName + '/Realms/' + realmName + '/AuthenticationProviders/DefaultAuthenticator')
cmo.setControlFlag('SUFFICIENT')
save()
activate(block="true")
print('----------------------------------------------------------------------------')
print('Alterado . . .')
print('----------------------------------------------------------------------------')
systime.sleep(5)


##Criando o novo provider
print('----------------------------------------------------------------------------')
print('Configurando LDAP Provider. . . ')
print('----------------------------------------------------------------------------')
edit()
startEdit()
##criando o ldap provider . . .
cd('/SecurityConfiguration/' + domainName + '/Realms/' + realmName)
cmo.createAuthenticationProvider(ldapProviderName, 'weblogic.security.providers.authentication.OpenLDAPAuthenticator')
##configurando o ldap provider ldapProviderName
cd('/SecurityConfiguration/' + domainName + '/Realms/' + realmName + '/AuthenticationProviders/' + ldapProviderName)
cmo.setControlFlag('SUFFICIENT')
cmo.setPrincipal(ldapPrincipal)
cmo.setHost(ldapHost)
set("Credential",ldapAdminPassword)
cmo.setGroupBaseDN('groupBaseDN')
cmo.setUserBaseDN('userBaseDN')
cmo.setUserNameAttribute(userNameAttribute)
cmo.setGroupFromNameFilter(groupFromNameFilter)
cmo.setStaticGroupObjectClass(staticGroupObjectClass)
cmo.setStaticGroupObjectClass(staticGroupObjectClass)
cmo.setStaticGroupDNsfromMemberDNFilter(staticGroupDNsfromMemberDNFilter)
cmo.setStaticMemberDNAttribute(staticMemberDnAttribute)
systime.sleep(5)
print('----------------------------------------------------------------------------')
print('configuring ldap provider . . . done')
print('----------------------------------------------------------------------------')
save()
activate(block="true")
print('----------------------------------------------------------------------------')
print('disconnecting from admin server....')
print('----------------------------------------------------------------------------')
disconnect()
exit()
