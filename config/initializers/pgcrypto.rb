if Rails.env.production?
  PGCrypto.keys[:private] = {:value => ENV['PRIVATE_KEY'], armored: true, password: ENV['PRIVATE_KEY_PASSWORD']}
  PGCrypto.keys[:public] = {:value => ENV['PUBLIC_KEY']}
else
  PGCrypto.keys[:private] = {:path => '/Users/murph/Desktop/secret.key', armored: true, password: ENV['PRIVATE_KEY_PASSWORD']}
  PGCrypto.keys[:public] = {:path => '/Users/murph/Desktop/public.key'}
end
