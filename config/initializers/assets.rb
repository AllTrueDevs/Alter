Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

######################### Stylesheets
Rails.application.config.assets.precompile += %w(
  applications.scss
  fonts.scss
  layouts.scss
  scaffolds.scss
  home.scss
)

######################### JS
Rails.application.config.assets.precompile += %w(
  plugins/user_tabs.js
  plugins/multiselect.coffee
  plugins/file-field.coffee
  plugins/preloader.coffee
  plugins/slider.coffee
  plugins/share_buttons.js
  plugins/bank_widget.js
  user-tabs.coffee
  categories_with_labels.js
  selection_color.coffee
)
