local helpers = require('test.functional.helpers')(after_each)
local Screen = require('test.functional.ui.screen')
local command = helpers.command
local insert = helpers.insert

describe('Autoread', function()
  it('filewatcher generate prompt', function()
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

    io.print(os.getenv('VIMRUNTIME'))
    helpers.write_file(path, expected_additions)
    command('call autoread#PromptReload()')
    screen:snapshot_util()
  end)
end)
