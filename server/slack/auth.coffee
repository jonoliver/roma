Roma.Auth =
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
      
      # set snooze temporarily for fun
      url = "https://slack.com/api/dnd.setSnooze?token=#{content.access_token}&num_minutes=1"
      console.log url
      HTTP.call 'GET', url, (error, response) ->
        console.log error, response.content
