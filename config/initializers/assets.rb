Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w(
  user_tabs.js
  *.png
  multiselect.js.coffee
  user-tabs.js.coffee
  file-field.js.coffee
  categories_with_labels.js.erb
  selection_color.js.coffee
  preloader.js.coffee
  slider.js.coffee
  share_buttons.js
)
