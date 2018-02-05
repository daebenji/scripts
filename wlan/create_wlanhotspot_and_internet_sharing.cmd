:: start as admin
NETSH WLAN set hostednetwork mode=allow ssid=foobar key=rabooffoobar
NETSH WLAN start hostednetwork
:: check if your Network Card supports hosted network
:: NETSH WLAN show drivers

:: make sure internet connection is shared with your hosted-network within your adapter-settings 