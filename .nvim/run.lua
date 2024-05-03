-- .nvim/run.lua ---------------------------------------------------------------
-- Globals ---------------------------------------------------------------------
local g_build_type = 'Release'
local g_executable = '.\\build\\VIS.exe'
local g_executable_args = { '' }
-- FncDefinitions --------------------------------------------------------------
function in_args(a)
    for i,v in ipairs(arg) do
        if v == a then 
            return true
        end
    end
    return false
end
function to_cmd(arr)
    local result_cmd = ''
    for i,v in ipairs(arr) do
        result_cmd = result_cmd .. v .. ' '
    end
    return result_cmd
end
function setup()
    print('@setup(cmake)')
    setup_cmd = {
        'cmake',
        '-G "Ninja"',
        '-S ./',
        '-B ./build/',
        '-DCMAKE_BUILD_TYPE=' .. g_build_type,
    }
    os.execute(to_cmd(setup_cmd))
end
function build()
    print('@build(cmake)')
    build_cmd = {
        'cmake',
        '--build ./build/',
    }
    os.execute(to_cmd(build_cmd))
end
function run()
    print('@run(' .. g_executable .. ' ' .. to_cmd(g_executable_args) .. ')')
    os.execute(g_executable .. ' ' .. to_cmd(g_executable_args))
end
-- Handle Args -----------------------------------------------------------------
print('')
if arg[1] == nil then
    setup()
    build()
    run()
    return
end
if in_args('--debug') then
    g_build_type = 'Debug'
end
if in_args('--release') then
    g_build_type = 'Release'
end
if in_args('--build') then
    setup()
    build()
    return
end
if in_args('--setup') then
    setup()
    return
end
-- End -------------------------------------------------------------------------
