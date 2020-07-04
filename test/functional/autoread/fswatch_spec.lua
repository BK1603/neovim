local helpers = require('test.functional.helpers')(after_each)
local Screen = require('test.functional.ui.screen')
local lfs = require('lfs')
local command = helpers.command
local insert = helpers.insert
local clear = helpers.clear
local feed = helpers.feed
local eval = helpers.eval

describe('Autoread', function()
  it('filewatcher generate prompt', function()
    print(eval('$PROJECT_SOURCE_DIR'))
    clear({env = {VIMRUNTIME='$PROJECT_SOURCE_DIR/runtime'}})
    local path = 'Xtest-foo'
    helpers.write_file(path, '')

    local screen = Screen.new(3, 8)
    screen:attach()

    command('edit! '..path)
    insert([[aa bb]])
    command('write')
    screen:snapshot_util()

    local expected_additions = [[
    line 1
    line 2
    line 3
    line 4
    ]]

    helpers.write_file(path, expected_additions)
    command('call fswatch#PromptReload()')
    screen:snapshot_util()
    feed([[y]])
    command('redraw')
  end)
end)
