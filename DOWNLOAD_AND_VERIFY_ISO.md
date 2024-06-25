### 2.4.80-20240624 ISO image released on 2024/06/25


### Download and Verify

2.4.80-20240624 ISO image:  
https://download.securityonion.net/file/securityonion/securityonion-2.4.80-20240624.iso
 
MD5: 139F9762E926F9CB3C4A9528A3752C31  
SHA1: BC6CA2C5F4ABC1A04E83A5CF8FFA6A53B1583CC9  
SHA256: 70E90845C84FFA30AD6CF21504634F57C273E7996CA72F7250428DDBAAC5B1BD  

Signature for ISO image:  
https://github.com/Security-Onion-Solutions/securityonion/raw/2.4/main/sigs/securityonion-2.4.80-20240624.iso.sig

Signing key:  
https://raw.githubusercontent.com/Security-Onion-Solutions/securityonion/2.4/main/KEYS  

For example, here are the steps you can use on most Linux distributions to download and verify our Security Onion ISO image.

Download and import the signing key:  
```
wget https://raw.githubusercontent.com/Security-Onion-Solutions/securityonion/2.4/main/KEYS -O - | gpg --import -  
```

Download the signature file for the ISO:  
```
wget https://github.com/Security-Onion-Solutions/securityonion/raw/2.4/main/sigs/securityonion-2.4.80-20240624.iso.sig
```

Download the ISO image:  
```
wget https://download.securityonion.net/file/securityonion/securityonion-2.4.80-20240624.iso
```

Verify the downloaded ISO image using the signature file:  
```
gpg --verify securityonion-2.4.80-20240624.iso.sig securityonion-2.4.80-20240624.iso
```

The output should show "Good signature" and the Primary key fingerprint should match what's shown below:
```
gpg: Signature made Mon 24 Jun 2024 02:42:03 PM EDT using RSA key ID FE507013
gpg: Good signature from "Security Onion Solutions, LLC <info@securityonionsolutions.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: C804 A93D 36BE 0C73 3EA1  9644 7C10 60B7 FE50 7013
```

If it fails to verify, try downloading again. If it still fails to verify, try downloading from another computer or another network.

Once you've verified the ISO image, you're ready to proceed to our Installation guide:  
https://docs.securityonion.net/en/2.4/installation.html
