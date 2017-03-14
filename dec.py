lista = [
'{AES}sdas87d967a7d6','{AES}' 
]
domain = "domain_home"
service = weblogic.security.internal.SerializedSystemIni.getEncryptionService(domain)
encryption = weblogic.security.internal.encryption.ClearOrEncryptedService(service)
for password in lista:
    print encryption.decrypt(password)
