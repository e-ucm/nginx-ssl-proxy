# How to create self-signed certs using Ubuntu 15.04's easy-rsa

1. Install easy-rsa: 
    `sudo apt-get install easy-rsa`
2. Create the folder where you will generate your certs:
    `make-cadir testdir`
3. Go to that folder:
    `cd testdir`
4. Change the configuration in `vars`. Sample values follow:
    ~~~~
        # this line was completely broken in the template
        export KEY_CONFIG="$EASY_RSA/openssl-1.0.0.cnf
    
        # ...
        
        export KEY_COUNTRY="ES"
        export KEY_PROVINCE="Madrid"
        export KEY_CITY="Madrid"
        export KEY_ORG="e-UCM"
        export KEY_EMAIL="admin@e-ucm.es"
        export KEY_OU="e-UCM Research Group"
    
        # X509 Subject Field
        export KEY_NAME="e-UCM CA"
    ~~~~
5. Run these commands, one by one:
    ~~~~
        source ./vars
        ./clean-all
        ./build-dh   
        ./pkitool --initca
        ./pkitool --server <servername>
    ~~~~
6. Go to the keys folder:
    `cd keys`
6. Build a chained certificate from ca.crt and `<servername>.crt`:
    `cat <servername.crt> ca.crt > public.crt`
  and then remove anything that is not sandwiched between 
    ~~~~
        -----BEGIN CERTIFICATE-----
        -----END CERTIFICATE-----
    ~~~~
  (or is one of these delimiters).
7. copy your .key file to private.key:
    `cp <servername>.key private.key`
8. copy the whole keys dir to the root of the rage-auth2 folder.
   You can safely remove anything except:
    ~~~~
        public.crt
        private.key
        dh2048.pem
    ~~~~
