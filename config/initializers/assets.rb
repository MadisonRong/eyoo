# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( jquery-ui-1.10.3.custom.min.js )
Rails.application.config.assets.precompile += %w( ace-elements.min.js )
Rails.application.config.assets.precompile += %w( date-time/bootstrap-datepicker.min.js )
Rails.application.config.assets.precompile += %w( jqGrid/jquery.jqGrid.min.js )
Rails.application.config.assets.precompile += %w( jqGrid/i18n/grid.locale-en.js )
Rails.application.config.assets.precompile += %w( highcharts.js )
Rails.application.config.assets.precompile += %w( uploadify/jquery.uploadify.min.js )
