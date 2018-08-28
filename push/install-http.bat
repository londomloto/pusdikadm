nssm remove PusdikadmHttpPushServer
nssm install PusdikadmHttpPushServer "C:\Program Files\nodejs\node.exe"
nssm set PusdikadmHttpPushServer AppDirectory "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push"
nssm set PusdikadmHttpPushServer AppParameters "index.js"
nssm set PusdikadmHttpPushServer AppStdout "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push\logs\http.log"
nssm set PusdikadmHttpPushServer AppStderr "D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm-push\logs\http_error.log"
nssm set PusdikadmHttpPushServer AppEnvironmentExtra "PORT=8080"
nssm start PusdikadmHttpPushServer