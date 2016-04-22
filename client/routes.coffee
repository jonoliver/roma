FlowRouter.route '/'

if Roma.isEnabled('slack')
  FlowRouter.route '/auth',
    name: 'Auth'
    action: (params, queryParams) ->
      Meteor.call 'authorize', queryParams.code
      FlowRouter.go '/'