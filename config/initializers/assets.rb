# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Rails.application.config.assets.precompile += %w(application.bootstrap.scss messages.scss users.scss)

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('vendor', 'javascript')
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(bootstrap.min.js bootstrap.bundle.min.js bootstrap.js popper.js application.scss @popperjs--core.js jquery.js)
