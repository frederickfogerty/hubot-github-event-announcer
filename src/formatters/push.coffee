{ordinal} = require './helpers'

# Public: Formats the [push event](https://developer.github.com/v3/activity/events/types/#pushevent)
# for announcement into the chat.
#
# ## Example
#
# ```
# user-name pushed 1 commit to foo/bar
#  * Add some feature
#
# https://github.com/foo/bar/compare/59c6a6a81a0a...651ef72811f2
# ```
#
# * `event` Push event.
#
# Returns a {String} containing the announcement.
module.exports = (event) ->
  data = event.data
  return unless data.commits and data.commits.length > 0

  message = "[#{data.repository.full_name}] #{data.pusher.name} pushed #{ordinal(data.commits.length, 'commit')}"
  message += "\n * #{commit.message.split("\n")[0]}" for commit in data.commits
  message
