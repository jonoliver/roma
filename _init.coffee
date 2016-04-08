@Roma = {};

@Roma.isEnabled = (feature) ->
  Meteor.settings.public["#{feature}Enabled"]