# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_evchina_session',
  :secret      => '8c1f85214d4bfe7ea0bc404488e1ca464c384b9756ee7a69a368dbf7580db3598b7f0179ac6ddcb17e9b8807f8ab411eeb2c27ddaa8696dff18531c3748b1b0f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
