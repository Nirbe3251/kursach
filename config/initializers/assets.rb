# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Rails.application.config.assets.precompile += %w(application.bootstrap.scss messages.scss users.scss)

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'javascript')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'stylesheets')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( 
    theme.css 
    appear.min.js 
    bootstrap.bundle.min.js
    buttons.colVis.min.js
    buttons.flash.min.js
    buttons.html5.min.js
    buttons.print.min.js
    dataTables.buttons.min.js
    hs-counter.min.js
    hs-file-attach.min.js
    hs-form-search.min.js
    hs-nav-scroller.min.js
    hs-navbar-vertical-aside-mini-cache.js
    hs-navbar-vertical-aside.min.js
    hs-step-form.min.js
    hs-toggle-password.js
    hs.bs-dropdown.js
    hs.core.js
    hs.datatables.js
    hs.imask.js
    hs.theme-appearance.js
    hs.tom-select.js
    imask.min.js
    jquery-migrate.min.js
    jquery.dataTables.min.js
    jquery.min.js
    jszip.min.js
    pdfmake.min.js
    select.min.js
    tom-select.complete.min.js
    vfs_fonts.js
    hs-mega-menu.min.js
)
