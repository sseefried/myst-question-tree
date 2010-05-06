# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_myst-question-tree_session',
  :secret      => 'c0139ccaa2fee852a77288d5a0a1681b8b58f5f151dbf223f29cb8e3683356af6d0177e391b19ae19b6a9f01ca4b08f18632b04aa54884ad7ddbc25cdfb766f7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
