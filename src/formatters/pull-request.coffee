module.exports = (event) ->
  switch event.data.action
    when 'opened', 'closed', 'reopened' then openEvent(event)
    when 'assigned', 'unassigned' then assignEvent(event)
    when 'labeled', 'unlabeled' then labelEvent(event)

openEvent = ({data}) ->
  pullRequest = data.pull_request
  sender = data.sender
  repo = data.repository
  verb =
    if pullRequest.merged
      'merged'
    else
      data.action

  """
  [#{repo.full_name}] #{sender.login} #{verb} PR ##{data.number}: #{pullRequest.title}
  """

assignEvent = ({data}) ->
  pullRequest = data.pull_request
  repo = data.repository
  sender = data.sender
  verb = data.action
  assignee = data.assignee.login
  assignee = 'themselves' if assignee is sender.login

  """
  [#{repo.full_name}] #{sender.login} #{verb} #{assignee} to PR ##{data.number}: #{pullRequest.title}
  """

labelEvent = ({data}) ->
  pullRequest = data.pull_request
  repo = data.repository
  sender = data.sender
  label = data.label.name
  verb =
    switch data.action
      when 'labeled' then 'added'
      when 'unlabeled' then 'removed'

  """
  [#{repo.full_name}] #{sender.login} #{verb} the label #{label} to PR ##{data.number}: #{pullRequest.title}
  """
