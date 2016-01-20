# Uncomment the line below and point it to your private key
PGCrypto.keys[:private] = {:path => '/Users/murph/Desktop/secret.key', armored: true, password: ENV['PGC_PRIVATE_PASSWORD']}
PGCrypto.keys[:public] = {:path => '/Users/murph/Desktop/public.key'}
