#enable firewall rules for scom agent
#version 0.1 - need to test this still

New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 5723 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 135 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 137 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 138 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 139 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 445 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 49152-65535 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 5723 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 80 -Profile Domain -Action Allow
New-NetFirewallRule -DisplayName "SCOM AGENT" -PROTOCOL TCP -LocalPort 443 -Profile Domain -Action Allow
