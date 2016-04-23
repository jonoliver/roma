accessToken = -> Meteor.user().profile.slack.access_token
  
Roma.Slack.API =
  endDnd: -> @call { endpoint: "dnd.endDnd" }

  setSnooze: (num_minutes) ->
    @call {
      endpoint: "dnd.setSnooze"
      params: { num_minutes: num_minutes }
    }

  call: (settings) ->
    params = @params settings.params
    url = "https://slack.com/api/#{settings.endpoint}"
    HTTP.call 'GET', url, params, (error, response) ->
      console.log error, response.content
    
  params: (params) -> params: _.extend { token: accessToken() }, params
    