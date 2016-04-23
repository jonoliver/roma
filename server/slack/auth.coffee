Roma.Slack.Auth =
  access: (code) ->
    console.log 'calling Roma.Auth.access'

    params = params:
      client_id: Meteor.settings.public.slack.client_id
      client_secret: process.env.SLACK_SECRET
      code: code
      redirect_uri: Meteor.settings.public.slack.redirect_uri

    console.log params

    HTTP.call 'GET', 'https://slack.com/api/oauth.access', params, (error, response) ->
      console.log error, response.content
      content = JSON.parse(response.content)
      
      if (content.ok)
        console.log 'Meteor user id:'
        console.log Meteor.userId()
        Meteor.users.update({_id:Meteor.userId()}, {$set:{'profile.slack.access_token':content.access_token}})