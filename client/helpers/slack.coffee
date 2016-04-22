Template.slack.helpers
  isEnabled: -> Roma.isEnabled('slack')
  href: ->
    params =
      client_id: Meteor.settings.public.slack.client_id
      redirect_uri: Meteor.settings.public.slack.redirect_uri
      team: "POMIET"
      scope: ["dnd:write", "dnd:read"]
    query = $.param(params, true)
    "https://slack.com/oauth/authorize?#{query}"