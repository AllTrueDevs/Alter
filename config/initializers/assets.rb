Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

######################### Stylesheets
Rails.application.config.assets.precompile += %w(
  applications.scss
  fonts.sass
  layouts.sass
  scaffolds.sass
  home.sass
  about.sass
  index_show.sass
  messages.sass
  login_signup.sass
  items.sass
)

######################### JS
Rails.application.config.assets.precompile += %w(
  plugins/user_tabs.js
  plugins/multiselect.coffee
  plugins/file-field.coffee
  plugins/preloader.coffee
  plugins/share_buttons.js
  plugins/tags-field.coffee
  plugins/infinite-loader.coffee
  plugins/progress-bars.coffee
  tabs.coffee
  selection_color.coffee
  home.coffee
  articles.coffee
  messages.coffee
  items.coffee
  user-forms.coffee
)
