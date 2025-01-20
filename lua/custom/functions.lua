return {
  opengl = function(function_name)
    vim.cmd('!explorer https://registry.khronos.org/OpenGL-Refpages/gl4/html/' .. function_name .. '.xhtml')
  end,
}
