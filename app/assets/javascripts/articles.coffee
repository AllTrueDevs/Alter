#= require plugins/tags-field

$ ->
  for tag in gon.default_tags_collection
    $('.tags-field')[0].selectize.addOption({
      value: tag,
      text: tag
    })