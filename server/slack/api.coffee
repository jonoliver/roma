accessToken = -> Meteor.user().profile.slack.access_token
  
Roma.Slack.API =
  endDnd: -> @call { endpoint: "dnd.endDnd" }

  setSnooze: (num_minutes) ->
    @call {
      endpoint: "dnd.setSnooze"
      params: { num_minutes: num_minutes }
    }

  usersInfo: (userId, callback) ->
    @call {
      endpoint: "users.info"
      params: { user: userId }
    }, callback
    
  call: (settings, callback = ->) ->
    params = @params settings.params
    url = "https://slack.com/api/#{settings.endpoint}"
    HTTP.call 'GET', url, params, (error, response) ->
      console.log error, response.content
      callback(JSON.parse response.content)
    
  params: (params) -> params: _.extend { token: accessToken() }, params
    