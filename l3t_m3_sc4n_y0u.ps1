#enable the firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

#allow scanner to connect on any port inbound
New-NetFirewallRule -DisplayName “Allow Nessus Vulnerability Scan” -Direction Inbound  -RemoteAddress $remoteIP -Action Allow
