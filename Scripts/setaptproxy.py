import os
import re

gateways = ["192.168.0.1", "10.50.0.1"]
currentgatway = (os.popen('ip route | grep default')).read()

if re.search('|'.join(gateways), currentgatway):
    os.system('echo "Acquire::http::Proxy \\"http://10.50.0.4:3142\\";" > /etc/apt/apt.conf.d/00aptproxy')
else:
    try:
        os.remove('/etc/apt/apt.conf.d/00aptproxy')
    except:
        print("Error")
