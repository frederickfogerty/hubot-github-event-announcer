# Public: Formats the [ping event](https://developer.github.com/webhooks/#ping-event)
# for announcement into the chat.
#
# ## Example
#
# ```
# GitHub sent a Webhook Ping event: Keep it logically awesome.
#
# https://api.github.com/orgs/lifted-studios/hooks/12345
# ```
#
# * `event` Ping event.
#
# Returns a {String} containing the announcement.
module.exports = (event) ->
  data = event.data
  """
  GitHub sent a Webhook Ping event: #{data.zen}

  #{data.hook.url}
  """
