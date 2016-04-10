@Roma = {};
@Roma.intervals = {}

@Roma.isEnabled = (feature) ->
  Meteor.settings.public["#{feature}Enabled"]