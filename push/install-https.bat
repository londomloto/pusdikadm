nssm remove PusdikadmHttpsPushServer
nssm install PusdikadmHttpsPushServer "C:\Program Files\nodejs\node.exe"
nssm set PusdikadmHttpsPushServer AppDirectory "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push"
nssm set PusdikadmHttpsPushServer AppParameters "index-ssl.js"
nssm set PusdikadmHttpsPushServer AppStdout "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push\logs\https.log"
nssm set PusdikadmHttpsPushServer AppStderr "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push\logs\https_error.log"
nssm set PusdikadmHttpsPushServer AppEnvironmentExtra "PORT=8443"
nssm start PusdikadmHttpsPushServer